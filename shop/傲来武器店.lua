-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-08-17 00:52:55
-- @Last Modified time  : 2022-09-02 09:56:27
local 商店 = {}

local list = {
    { 类别 = "普通装备", 名称 = "水弧刀", 价格 = 80000 },
    { 类别 = "普通装备", 名称 = "巨灵锤", 价格 = 80000 },
    { 类别 = "普通装备", 名称 = "空心斧", 价格 = 80000 },
    { 类别 = "普通装备", 名称 = "六道无常", 价格 = 80000 },
    { 类别 = "普通装备", 名称 = "八卦扇", 价格 = 80000 },
    { 类别 = "普通装备", 名称 = "烈焰拂尘", 价格 = 80000 },
    { 类别 = "普通装备", 名称 = "干将宝剑", 价格 = 80000 },
    { 类别 = "普通装备", 名称 = "勾魂索", 价格 = 80000 },
    { 类别 = "普通装备", 名称 = "血烟长矛", 价格 = 80000 },
    ---  { 类别 = "普通装备", 名称 = "夺魄幡", 价格 = 80000 },
    { 类别 = "普通装备", 名称 = "缚龙紫纱", 价格 = 80000 },
    { 类别 = "普通装备", 名称 = "吴钩", 价格 = 80000 },
    { 类别 = "普通装备", 名称 = "霹雳拳套", 价格 = 80000 },
    { 类别 = "普通装备", 名称 = "灭魂爪", 价格 = 80000 },
    { 类别 = "普通装备", 名称 = "子美之卷", 价格 = 80000 },
    { 类别 = "普通装备", 名称 = "耀日金环", 价格 = 80000 },
    { 类别 = "普通装备", 名称 = "萤火灯笼", 价格 = 80000 },
}

function 商店:取商品()
    return list
end

function 商店:购买(玩家, i, n)
    local 总价 = n * list[i].价格
    if 玩家.银子 >= 总价 then
        local t = 复制表(list[i])
        t.类别 = nil
        t.价格 = nil
        local 物品表 = {}

        for _ = 1, n do
            table.insert(物品表, 生成装备(t))
        end

        if 玩家:添加物品_无提示(物品表) then
            玩家:扣除银子(总价)
            玩家:提示窗口('#Y你购买了%s个#G%s#Y,共花费%s银两。', n, t.名称, 总价)
            return true
        else
            return '#Y空间不足'
        end

    else
        return '#Y你的银两不足，不能购买！'
    end
end

return 商店
