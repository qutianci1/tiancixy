-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-08-17 00:52:55
-- @Last Modified time  : 2022-09-02 09:56:27
local 商店 = {}

local list = {
    { 类别 = "普通装备", 名称 = "布鞋", 价格 = 500 },
    { 类别 = "普通装备", 名称 = "佛珠", 价格 = 500 },
    { 类别 = "道具", 名称 = "金柳露", 价格 = 50000 },
    { 类别 = "道具", 名称 = "卧龙丹", 价格 = 200000 },
    { 类别 = "材料", 名称 = "武帝袍", 价格 = 5000 },
    { 类别 = "材料", 名称 = "云罗帐", 价格 = 5000 },
    { 类别 = "材料", 名称 = "雪蟾蜍", 价格 = 5000 },
    { 类别 = "材料", 名称 = "霄汉鼎", 价格 = 5000 },
    { 类别 = "材料", 名称 = "灵犀角", 价格 = 5000 },
    { 类别 = "材料", 名称 = "烈焰砂", 价格 = 5000 },
    { 类别 = "材料", 名称 = "沧海珠", 价格 = 5000 },
    { 类别 = "材料", 名称 = "蓝田玉", 价格 = 5000 },
    { 类别 = "材料", 名称 = "盘古石", 价格 = 5000 },
    -- { 类别 = "材料", 名称 = "辟邪珠", 价格 = 5000 },
    -- { 类别 = "材料", 名称 = "忆梦符", 价格 = 5000 },
}

function 商店:取商品()
    return list
end

function 商店:购买(玩家, i, n)
    local 总价 = n * list[i].价格
    if 玩家.银子 >= 总价 then
        local t = 复制表(list[i])
        local 物品表 = {}
        if t.类别 ~= "普通装备" then

            t.类别 = nil
            t.价格 = nil
            local 第一 = 生成物品(t)
            if 第一.是否叠加 then
                第一.数量 = n
                table.insert(物品表, 第一)
            else
                for _ = 1, n do
                    table.insert(物品表, 生成物品(t))
                end
            end
        else
            t.类别 = nil
            t.价格 = nil
            local 第一 = 生成装备(t)
            if 第一.是否叠加 then
                第一.数量 = n
                table.insert(物品表, 第一)
            else
                for _ = 1, n do
                    table.insert(物品表, 生成装备(t))
                end
            end

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
