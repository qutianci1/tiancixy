-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-08-17 00:52:55
-- @Last Modified time  : 2022-09-02 09:58:01
local 商店 = {}

local list = {
    { 类别 = "道具", 名称 = "香草", 价格 = 80 },
    { 类别 = "道具", 名称 = "草果", 价格 = 80 },
    { 类别 = "道具", 名称 = "金针", 价格 = 150 },
    { 类别 = "道具", 名称 = "黑山药", 价格 = 40 },
    { 类别 = "道具", 名称 = "七叶莲", 价格 = 100 },
    { 类别 = "道具", 名称 = "八角莲叶", 价格 = 180 },
    { 类别 = "道具", 名称 = "天青地白", 价格 = 180 },
    { 类别 = "道具", 名称 = "水黄莲", 价格 = 220 },
    { 类别 = "道具", 名称 = "月见草", 价格 = 220 },
    { 类别 = "道具", 名称 = "凤凰尾", 价格 = 250 },
    { 类别 = "道具", 名称 = "紫丹罗", 价格 = 250 },
    { 类别 = "道具", 名称 = "百色花", 价格 = 300 },
    { 类别 = "道具", 名称 = "香叶", 价格 = 300 },
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
        local 第一 = 生成物品(t)
        if 第一.是否叠加 then
            第一.数量 = n
            table.insert(物品表, 第一)
        else
            for _ = 1, n do
                table.insert(物品表, 生成物品(t))
            end
        end
        if 玩家:添加物品_无提示(物品表) then
            玩家:扣除银子(总价)
            玩家:提示窗口('#Y你购买了%s个#G%s#Y,共花费%s银两。',  n,t.名称, 总价)
            return true
        else
            return '#Y空间不足'
        end

    else
        return '#Y你的银两不足，不能购买！'
    end
end

return 商店
