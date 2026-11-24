-- a clientside animation spoofer.
-- Usefull with a saveinstance script, this tool allows you to get any game's animations simply by having a humanoid play it.
-- You can then export the animations as a .rbxmx file, ready for studio.
-- how does it work ? It collects all humanoids, checks what animations they are playing, get those animation's ids and finally uses AnimationClipProvider to rip the animation's keyframes out of the id

-- We Live We Love We Lie, I made this script, me, ye, skira, solal0, sorta, yeah, enjoy

local U = loadstring(game:HttpGet("https://raw.githubusercontent.com/solal0/Luau/refs/heads/main/Tools/Utils.luau"))()
local L = loadstring(game:HttpGet("https://skira.me/lua/SkiraLibrary/source"))()
local AP = game:GetService("AnimationClipProvider")
local MS = game:GetService("MarketplaceService")

local Queue,Seen,Connections,Animators = {},{},{},{}
local Running,Exporting,Processing,Cancelled,Closed = true,false,false,false,false

local g = U.getGui()

local Folder = Instance.new("Folder",g)
Folder.Name = "ExportedAnims"

local Gui = L:Begin(g,"Anim Spoofer")
Gui.ResetOnSpawn = false

function Notify(Message,Title,Duration)
    if not Gui.Parent or Closed then return end
    task.spawn(function()
        pcall(L.Notify,L,Gui,Duration or 4,{text = Message,title = Title or "Anim Spoofer",btntype = 0})
    end)
end

function GetId(Value)
    Value = tostring(Value)
    return Value:match("^%s*(%d+)%s*$") or Value:match("rbxassetid://(%d+)") or Value:match("[?&][Ii][Dd]=(%d+)")
end

function Property(Type,Name,Value)
    return string.format('<%s name="%s">%s</%s>',Type,Name,tostring(Value):gsub("[%z\1-\8\11\12\14-\31]",""):gsub("&","&amp;"):gsub("<","&lt;"):gsub(">","&gt;"):gsub('"',"&quot;"):gsub("'","&apos;"),Type)
end

function Serialize(Root)
    local Output = {'<?xml version="1.0" encoding="utf-8"?>','<roblox version="4"><External>null</External><External>nil</External>'}
    local Reference = 0

    local function Add(Value)
        Output[#Output+1] = Value
    end

    local function Write(Object)
        if not (Object:IsA("Folder") or Object:IsA("KeyframeSequence") or Object:IsA("Keyframe") or Object:IsA("Pose") or Object:IsA("NumberPose") or Object:IsA("KeyframeMarker")) then return end

        Reference += 1
        Add(string.format('<Item class="%s" referent="RBX%d"><Properties>',Object.ClassName,Reference))
        Add(Property("string","Name",Object.Name))

        if Object:IsA("KeyframeSequence") then
            Add(Property("bool","Loop",Object.Loop))
            Add(Property("token","Priority",Object.Priority.Value))
            pcall(function()
                Add(Property("float","AuthoredHipHeight",Object.AuthoredHipHeight))
            end)
        elseif Object:IsA("Keyframe") then
            Add(Property("float","Time",Object.Time))
        elseif Object:IsA("Pose") then
            local Components = {Object.CFrame:GetComponents()}
            Add('<CoordinateFrame name="CFrame">')

            for Index,Name in {"X","Y","Z","R00","R01","R02","R10","R11","R12","R20","R21","R22"} do
                Add(string.format("<%s>%.17g</%s>",Name,Components[Index],Name))
            end

            Add("</CoordinateFrame>")
        elseif Object:IsA("NumberPose") then
            Add(Property("float","Value",Object.Value))
        elseif Object:IsA("KeyframeMarker") then
            Add(Property("string","Value",Object.Value))
        end

        if Object:IsA("Pose") or Object:IsA("NumberPose") then
            Add(Property("float","Weight",Object.Weight))
            Add(Property("token","EasingStyle",Object.EasingStyle.Value))
            Add(Property("token","EasingDirection",Object.EasingDirection.Value))
        end

        Add("</Properties>")

        for _,Child in Object:GetChildren() do
            Write(Child)
        end

        Add("</Item>")
    end

    Write(Root)
    Add("</roblox>")
    return table.concat(Output,"\n")
end

function DisconnectAnimator(Animator)
    if Animators[Animator] then
        Animators[Animator]:Disconnect()
        Animators[Animator] = nil
    end
end

function Disconnect()
    Running = false

    for _,Connection in Animators do
        Connection:Disconnect()
    end

    for _,Connection in Connections do
        Connection:Disconnect()
    end

    table.clear(Animators)
    table.clear(Connections)
end

function Close(Destroy)
    if Closed then return end
    Closed,Cancelled,Exporting = true,true,false
    Disconnect()
    table.clear(Queue)

    if Destroy ~= false and Gui.Parent then Gui:Destroy() end
end

local _,Content = L:Window(Gui,"Anim Spoofer",UDim2.fromOffset(400,125),{position = UDim2.new(0.5,-200,0.5,-62),callback = function(v) if v == "closing" then Close() end end})
local Holder = L:Holder(Content,{padding = UDim.new(0,4)})
local Left = L:Column(Holder,UDim2.new(0.3,0,0,0),Enum.HorizontalAlignment.Left)
local Right = L:Column(Holder,UDim2.new(0.7,0,0,0),Enum.HorizontalAlignment.Right)
Left.Name,Right.Name = "01","02"

for _,Sequence in Folder:GetChildren() do
    if not Sequence:IsA("KeyframeSequence") then continue end
    local Id = Sequence:GetAttribute("AnimationId") or Sequence.Name:match("%((%d+)%)$")
    if Id then Seen[tostring(Id)] = "Exported" end
end

function Enqueue(Id,Name,Manual)
    if not Running or Cancelled or not Id or (Seen[Id] and not (Manual and Seen[Id] == "Failed")) then return end

    Seen[Id] = "Queued"
    Queue[#Queue+1] = {Id = Id,Name = Name or Id}
    Notify((Manual and "Animation ID: " or "New animation detected, ID: ")..Id.." / Name: "..(Name or Id)..". Adding to queue.")
end

function Detect(Track)
    if not Running or Cancelled then return end

    local Success,Error = pcall(function()
        local Animation = Track.Animation
        if Animation then Enqueue(GetId(Animation.AnimationId),Animation.Name,false) end
    end)

    if not Success then warn("Anim Spoofer detection:",Error) end
end

function ScanAnimator(Animator)
    local Success,Tracks = pcall(Animator.GetPlayingAnimationTracks,Animator)

    if Success then
        for _,Track in Tracks do
            Detect(Track)
        end
    end
end

function RegisterAnimator(Animator)
    if not Running or Cancelled or Animators[Animator] or not Animator:IsDescendantOf(workspace) or not Animator.Parent or not Animator.Parent:IsA("Humanoid") then return end

    Animators[Animator] = Animator.AnimationPlayed:Connect(Detect)
    ScanAnimator(Animator)
end

function RegisterHumanoid(Humanoid)
    for _,Child in Humanoid:GetChildren() do
        if Child:IsA("Animator") then RegisterAnimator(Child) end
    end
end

function ExportAnimation(Id,Name)
    local Sequence

    local Success,Error = pcall(function()
        assert(not Cancelled,"Cancelled")

        local Source = AP:GetAnimationClipAsync("rbxassetid://"..Id)
        assert(Source,"Animation clip unavailable")
        assert(Source:IsA("KeyframeSequence"),"Unsupported animation clip type: "..Source.ClassName)
        assert(not Cancelled,"Cancelled")

        Sequence = Instance.new("KeyframeSequence")
        Sequence.Name = Name.." ("..Id..")"
        Sequence.Loop = Source.Loop
        Sequence.Priority = Source.Priority

        pcall(function() Sequence.AuthoredHipHeight = Source.AuthoredHipHeight end)

        local function Copy(Object,Parent)
            local Class = Object.ClassName
            if Class ~= "Keyframe" and Class ~= "Pose" and Class ~= "NumberPose" and Class ~= "KeyframeMarker" then return end

            local New = Instance.new(Class)
            New.Name = Object.Name
            New.Parent = Parent

            if Class == "Keyframe" then
                New.Time = Object.Time
            elseif Class == "Pose" then
                New.CFrame = Object.CFrame
            elseif Class == "NumberPose" or Class == "KeyframeMarker" then
                New.Value = Object.Value
            end

            if Class == "Pose" or Class == "NumberPose" then
                New.Weight = Object.Weight
                New.EasingStyle = Object.EasingStyle
                New.EasingDirection = Object.EasingDirection
            end

            for _,Child in Object:GetChildren() do
                Copy(Child,New)
            end
        end

        for _,Keyframe in Source:GetKeyframes() do
            Copy(Keyframe,Sequence)
        end

        assert(not Cancelled,"Cancelled")
        assert(#Sequence:GetKeyframes() > 0,"Animation contains no keyframes")

        Sequence:SetAttribute("AnimationId",Id)
        Sequence.Parent = Folder
    end)

    if not Success and Sequence then Sequence:Destroy() end
    return Success,Error
end

function ProcessQueue()
    if Processing or Cancelled then return end
    Processing = true

    while #Queue > 0 and not Cancelled do
        local Entry = table.remove(Queue,1)
        local Id = Entry.Id
        Seen[Id] = "Processing"

        local Success,Error = pcall(function()
            local Found,Info = pcall(MS.GetProductInfo,MS,tonumber(Id),Enum.InfoType.Asset)
            local Name = Found and Info and Info.Name or Entry.Name

            if Cancelled then return end

            local Exported,ExportError = ExportAnimation(Id,Name)
            assert(Exported,ExportError)

            Seen[Id] = "Exported"
            Notify(Name.." ("..Id..") exported successfully.","Success")
        end)

        if not Success then
            Seen[Id] = "Failed"

            if not Cancelled then
                Notify("Failed to export "..Id..": "..tostring(Error),"Error",6)
                warn("Anim Spoofer:",Id,Error)
            end
        end

        task.wait()
    end

    Processing = false
end

local TextBox

L:Button(Left,"Load",{alignmentX = Enum.TextXAlignment.Center,callback = function()
    if not Running or Cancelled then return end

    local Id = GetId(TextBox.Text)
    if not Id then Notify("Invalid animation ID.","Error") return end
    if Seen[Id] and Seen[Id] ~= "Failed" then Notify("Animation "..Id.." is already queued or exported.") return end

    Enqueue(Id,nil,true)
    TextBox.Text = ""
end})

TextBox = L:TextBox(Right,"",{text = "Animation ID"})

local FinalButton

FinalButton = L:Button(Content,"I got what I needed, export to file.",{alignmentX = Enum.TextXAlignment.Center,callback = function()
    if Exporting or Cancelled or Closed then return end

    Exporting = true
    FinalButton:SetAttribute("Inactive",true)
    Disconnect()
    Notify("Finishing remaining animations...")

    while not Cancelled and (Processing or #Queue > 0) do
        task.wait(0.1)
    end

    if Cancelled then return end

    local FileName = string.format("AnimSpoofer_%s_%s.rbxmx",tostring(game.GameId),os.date("%Y.%m.%d.%H.%M.%S"))

    local Success,Error = pcall(function()
        writefile(FileName,Serialize(Folder))
    end)

    if Success then
        Notify("Saved "..FileName,"Success",4)
        print("Anim Spoofer:",FileName)
    else
        Notify("File export failed: "..tostring(Error),"Error",5)
        warn("Anim Spoofer:",Error)
    end

    task.wait(Success and 2 or 5)
    Close()
end})

L:Label(Content,"Made by Skira / github.com/solal0",{wrapped = false})

Connections[#Connections+1] = Gui.Destroying:Connect(function()
    Close(false)
end)

Connections[#Connections+1] = workspace.DescendantAdded:Connect(function(Object)
    if not Running or Cancelled then return end

    if Object:IsA("Humanoid") then
        RegisterHumanoid(Object)
    elseif Object:IsA("Animator") then
        RegisterAnimator(Object)
    end
end)

Connections[#Connections+1] = workspace.DescendantRemoving:Connect(function(Object)
    if Object:IsA("Animator") then
        DisconnectAnimator(Object)
    elseif Object:IsA("Humanoid") then
        for _,Child in Object:GetChildren() do
            if Child:IsA("Animator") then DisconnectAnimator(Child) end
        end
    end
end)

task.spawn(function()
    for _,Object in workspace:GetDescendants() do
        if not Running or Cancelled then break end
        if Object:IsA("Humanoid") then RegisterHumanoid(Object) end
    end

    local LastScan = os.clock()

    while Running and not Cancelled do
        local Success,Error = pcall(function()
            for Animator,Connection in Animators do
                if not Animator:IsDescendantOf(workspace) or not Animator.Parent or not Animator.Parent:IsA("Humanoid") then
                    DisconnectAnimator(Animator)
                elseif not Connection.Connected then
                    DisconnectAnimator(Animator)
                    RegisterAnimator(Animator)
                else
                    ScanAnimator(Animator)
                end
            end

            if os.clock()-LastScan >= 5 then
                LastScan = os.clock()

                for _,Object in workspace:GetDescendants() do
                    if Object:IsA("Humanoid") then RegisterHumanoid(Object) end
                end
            end
        end)

        if not Success then warn("Anim Spoofer detection:",Error) end
        task.wait(0.25)
    end
end)

task.spawn(function()
    while not Cancelled and (Running or Exporting) do
        if #Queue > 0 and not Processing then
            local Success,Error = pcall(ProcessQueue)

            if not Success then
                Processing = false
                warn("Anim Spoofer queue:",Error)
                Notify(tostring(Error),"Queue error",5)
            end
        end

        task.wait(0.1)
    end
end)
