local aracMarkers = {}

function arac_bul(thePlayer, cmd, vehicleID)
    if not tonumber(vehicleID) then
        outputChatBox("#FF0000>> #FFFFFFKomut kullanımı: /" .. cmd .. " [araç ID]", thePlayer, 255, 0, 0, true)
        return false
    end

    local vehicle = exports.pool:getElement("vehicle", tonumber(vehicleID))
    if vehicle then
        local ownerID = getElementData(vehicle, "owner")
        local playerID = getElementData(thePlayer, "dbid")

        if ownerID == playerID then
            if aracMarkers[playerID] then
                outputChatBox("#FF0000>> #FFFFFFZaten bir araç konumu işaretlediniz.", thePlayer, 255, 0, 0, true)
                return false
            end

            local posX, posY, posZ = getElementPosition(vehicle)
            aracMarkers[playerID] = createMarker(posX, posY, posZ, "checkpoint", 3, 0, 255, 0, 150, thePlayer)
            outputChatBox("#00FF00[+] #FFFFFFAraç konumu başarıyla işaretlendi.", thePlayer, 0, 255, 0, true)
            outputChatBox("#00FF00[+] #FFFFFF/aracbulkapat yazarak araç konumunu kapatabilirsiniz.", thePlayer, 0, 255, 0, true)
        else
            outputChatBox("#FF0000>> #FFFFFFBu araç size ait değil.", thePlayer, 255, 0, 0, true)
        end
    else
        outputChatBox("#FF0000>> #FFFFFFBöyle bir araç bulunamadı.", thePlayer, 255, 0, 0, true)
    end
end
addCommandHandler("aracbul", arac_bul)

function aracKapat(thePlayer, cmd)
    local playerID = getElementData(thePlayer, "dbid")
    if aracMarkers[playerID] then
        destroyElement(aracMarkers[playerID])
        aracMarkers[playerID] = nil
        outputChatBox("#00FF00[+] #FFFFFFAraç konumu başarıyla kapatıldı.", thePlayer, 0, 255, 0, true)
    else
        outputChatBox("#FF0000>> #FFFFFFHenüz bir araç konumu işaretlememişsiniz.", thePlayer, 255, 0, 0, true)
    end
end
addCommandHandler("aracbulkapat", aracKapat)
