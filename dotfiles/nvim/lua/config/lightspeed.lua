local ok, lightspeed = pcall(require, "lightspeed")
if not ok then
  return
end


lightspeed.setup {
  ignore_case = true,
  jump_to_unique_chars = { safety_timeout = 400 },
}
