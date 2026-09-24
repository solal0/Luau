-- File created using ByteCode Inspector (https://github.com/solal0/Luau/)

-- Decompiled in 1s by luacid
-- Path: ReplicatedStorage.Scripts.GetBlockInfo
-- Class: ModuleScript

-- If the script cuts off, click Save below to have the full script as a file.

-- [[ luacid.dev ]] v0.2.13 decompiled at 2026-09-22T01:04:24Z
-- Luau bytecode version: 12 | Luau type version: 3
function getBlockInfo(arg1, arg2)
    if not arg1 or not arg1.Parent or typeof(arg1) ~= "Instance" then
        return
    end

    local blocks = workspace.Blocks
    local parent = arg1.Parent

    while parent and parent.Parent and parent ~= workspace and parent.Parent ~= blocks do
        arg1 = arg1.Parent
        parent = parent.Parent
    end

    if parent.Parent ~= blocks then
        return
    end

    local instance = game.Players:FindFirstChild(parent.Name)

    if not arg2 then
        return arg1, instance, false
    end

    local instance2 = game.Players:FindFirstChild(arg2.Team.TeamLeader.Value)

    return arg1, instance, not arg2.Settings.ShareBlocks.Value and instance == arg2 or arg2.Settings.ShareBlocks.Value and instance2 and instance == instance2
end

return getBlockInfo