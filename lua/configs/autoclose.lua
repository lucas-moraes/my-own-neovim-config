local status, autoclose = pcall(require, "autoclose")

if not status then
	return
end

autoclose.setup()
