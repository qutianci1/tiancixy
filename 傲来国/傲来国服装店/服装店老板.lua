local NPC = {}
local 对话 = [[
据说天下最漂亮的衣服出自月宫嫦娥之手。
menu
1|我想买点东西
2|我只是路过看看
]]

function NPC:NPC对话(玩家, i)
    return 对话
end

function NPC:NPC菜单(玩家, i)
    if i == '1' then
        玩家:购买窗口('scripts/shop/傲来服装店.lua')
    end
end

return NPC
