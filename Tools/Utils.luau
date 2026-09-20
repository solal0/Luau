local utils = {}

-- base64 made by xDeltaXen: https://www.roblox.com/users/1298068279
-- dev forum post: https://devforum.roblox.com/t/base64-encoding-and-decoding-in-lua/1719860

utils.encode = function(data)
	local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	return ((data:gsub('.', function(x) 
		local r,b='',x:byte()
		for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
		return r;
	end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
		if (#x < 6) then return '' end
		local c=0
		for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
		return b:sub(c+1,c+1)
	end)..({ '', '==', '=' })[#data%3+1])
end

-- this function converts base64 to string
utils.decode = function(data)
	local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	data = string.gsub(data, '[^'..b..'=]', '')
	return (data:gsub('.', function(x)
		if (x == '=') then return '' end
		local r,f='',(b:find(x)-1)
		for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
		return r;
	end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
		if (#x ~= 8) then return '' end
		local c=0
		for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
		return string.char(c)
	end))
end

-- I2B64 (https://github.com/solal0/I2B64) by CaptainSkira

utils.base64toImage = function(base64)
	local data
	
	if utils.icons[base64] then
		data = utils.decode(utils.icons[base64])
	else
		data = utils.decode(base64)
	end

	local pos = 1

	local function u8()
		local v = string.byte(data,pos)
		pos += 1
		return v
	end

	local function u16()
		return u8()*256+u8()
	end

	local width,height = u16(),u16()
	local paletteCount = u16()
	local palette = table.create(paletteCount)

	for i=1,paletteCount do
		palette[i-1] = {u8(),u8(),u8(),u8()}
	end

	local pixelCount = width*height
	local out = buffer.create(pixelCount*4)
	local p = 0

	while pos <= #data-3 and p < pixelCount do
		local count,index = u16(),u16()
		local c = palette[index]

		local r = math.floor(c[1]*255/99+0.5)
		local g = math.floor(c[2]*255/99+0.5)
		local b = math.floor(c[3]*255/99+0.5)
		local a = math.floor(c[4]*255/99+0.5)

		for _=1,count do
			if p >= pixelCount then break end

			local i = p*4
			buffer.writeu8(out,i,r)
			buffer.writeu8(out,i+1,g)
			buffer.writeu8(out,i+2,b)
			buffer.writeu8(out,i+3,a)

			p += 1
		end
	end

	if p ~= pixelCount then
		error("I2B64: image data ended before all pixels were decoded")
	end

	local image = game:GetService("AssetService"):CreateEditableImage({
		Size = Vector2.new(width,height)
	})

	image:WritePixelsBuffer(Vector2.new(0,0), Vector2.new(width,height), out)

	return Content.fromObject(image),image,width,height
	--     for Image instances,       raw    X      Y
end

return utils
