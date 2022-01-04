Scriptname MEKCAModInitialization extends ReferenceAlias  

Ammo Property MEKCAIronChairrow Auto
Ammo Property MEKCASteelChairrow Auto
Ammo Property MEKCAOrcishChairrow Auto
Ammo Property MEKCADwarvenChairrow Auto
Ammo Property MEKCAElvenChairrow Auto
Ammo Property MEKCAGlassChairrow Auto
Ammo Property MEKCAEbonyChairrow Auto
Ammo Property MEKCADaedricChairrow Auto

Projectile Property MEKCAChairrowIronProjectile Auto
Projectile Property MEKCAChairrowSteelProjectile Auto
Projectile Property MEKCAChairrowOrcishProjectile Auto
Projectile Property MEKCAChairrowDwarvenProjectile Auto
Projectile Property MEKCAChairrowElvenProjectile Auto
Projectile Property MEKCAChairrowGlassProjectile Auto
Projectile Property MEKCAChairrowEbonyProjectile Auto
Projectile Property MEKCAChairrowDaedricProjectile Auto

LeveledItem Property LItemBlacksmithMinimum Auto
LeveledItem Property BaseArrowIron75 Auto
LeveledItem Property DLC2LItemBlacksmithMinimum Auto
LeveledItem Property GuardGear Auto
LeveledItem Property CWSoldierSonsGear1H Auto
LeveledItem Property SublistThalmorArrowsSteel Auto
LeveledItem Property BaseArrowSteel75 Auto
LeveledItem Property BaseArrowOrcish75 Auto
LeveledItem Property LItemDraugr05WeaponArrowSublist Auto
LeveledItem Property BaseArrowDwarven75 Auto
LeveledItem Property SublistThalmorArrowsElven Auto
LeveledItem Property BaseArrowElven75 Auto
LeveledItem Property DLC1VendorElvenArrows Auto
LeveledItem Property DLC1LootElvenArrows25 Auto
LeveledItem Property SublistThalmorArrowsGlass Auto
LeveledItem Property BaseArrowGlass75 Auto
LeveledItem Property BaseArrowEbony75 Auto
LeveledItem Property LItemDraugr05EWeaponArrowSublist Auto
LeveledItem Property BaseArrowDaedric75 Auto
LeveledItem Property DLC1LootDragonDaedricArrows Auto

FormList Property ArrowTypeFormList Auto
FormList Property DLC1DBDunStatueArrowList Auto

float Property StoredModVersion = 0.0 Auto
float Property StoredImmersiveWeaponsVersion = 0.0 Auto
float Property StoredBaseLeveledListsVersion = 0.0 Auto

string ValdacilsItemSorting = "ValdacilsItemSorting.esp"
string UpdateText = "Chairrows (Chair Arrows) Updated to "
string LogPrefix = "[Chairrows] "

Event OnInit()
    RegisterForSingleUpdate(10.0)
EndEvent

Event OnPlayerLoadGame()
    RegisterForSingleUpdate(10.0)
EndEvent

Event OnUpdate()
    If (StoredModVersion < 2.0)
        Maintenance()
        StoredModVersion = 2.0
        Debug.Notification(UpdateText + "2.0")
    Else
        Maintenance()
    EndIf
EndEvent

Function Maintenance()
    Debug.Trace(LogPrefix + "=================Maintenance Start=================")
    UpdateBaseLeveledLists2_0()
    UpdateValdacilsItemSorting2_0()
    Debug.Trace(LogPrefix + "=================Maintenance End===================")
EndFunction

Function UpdateItemList(LeveledItem itemList, Form addItem, int itemLevel, int itemCount, int repeat = 1)
    int index = 0
    ; Try adding the item to Leveled Item List repeat number of times
    While (index < repeat)
        ; Leveled Lists can only have a max of 255 items, so skip if the list is full
        If (itemList.GetNumForms() == 255)
            ; break out of repeat loop
            index = repeat
            Debug.Trace(LogPrefix + "Skipping adding '" + addItem + "' to '" + itemList + "'. The list is full")
        Else
            Debug.Trace(LogPrefix + "Adding '" + addItem + "' Level '" + itemLevel + "' count '" + itemCount + "' to '" + itemList + "'")
            itemList.AddForm(addItem, itemLevel, itemCount)
        EndIf
        index += 1
    EndWhile
EndFunction

Function UpdateFormList(FormList itemList, Form addItem)
    If (itemList.GetSize() == 255)
        Debug.Trace(LogPrefix + "Skipping adding '" + addItem + "' to '" + itemList + "'. The list is full")
    Else
        Debug.Trace(LogPrefix + "Adding '" + addItem + "' to '" + itemList + "'")
        itemList.AddForm(addItem)
    EndIf
EndFunction

Function RenameWeaponValdacilsItemSorting(Ammo WeaponToRename)
    string prefix = "(Arrow) "
    string oldName = WeaponToRename.GetName()
    If (StringUtil.Find(oldName, prefix) != -1)
        Debug.Trace(LogPrefix + "'" + oldName + "' is already correct on '" + WeaponToRename + "'")
        Return
    EndIf
    string newName = prefix + oldName
    Debug.Trace(LogPrefix + "Renaming '" + oldName + "' to '" + newName + "' on '" + WeaponToRename + "'")
    WeaponToRename.SetName(newName)
EndFunction

Function UpdateBaseLeveledLists2_0()
    If (StoredBaseLeveledListsVersion < 2.0)
        StoredBaseLeveledListsVersion = 2.0
    Else
        Return
    EndIf
    Debug.Trace(LogPrefix + "==========Updating Base Game Leveled Lists=========")
    UpdateItemList(LItemBlacksmithMinimum, MEKCAIronChairrow, 1, 50, 1)
    UpdateItemList(BaseArrowIron75, MEKCAIronChairrow, 1, 1, 1)
    UpdateItemList(DLC2LItemBlacksmithMinimum, MEKCAIronChairrow, 1, 50, 1)

    UpdateItemList(GuardGear, MEKCASteelChairrow, 1, 12, 1)
    UpdateItemList(CWSoldierSonsGear1H, MEKCASteelChairrow, 1, 12, 1)
    UpdateItemList(SublistThalmorArrowsSteel, MEKCASteelChairrow, 1, 1, 1)
    UpdateItemList(BaseArrowSteel75, MEKCASteelChairrow, 1, 1, 1)

    UpdateItemList(BaseArrowOrcish75, MEKCAOrcishChairrow, 1, 1, 1)
    UpdateItemList(LItemDraugr05WeaponArrowSublist, MEKCAOrcishChairrow, 1, 1, 1)

    UpdateItemList(BaseArrowDwarven75, MEKCADwarvenChairrow, 1, 1, 1)

    UpdateItemList(SublistThalmorArrowsElven, MEKCAElvenChairrow, 1, 1, 1)
    UpdateItemList(BaseArrowElven75, MEKCAElvenChairrow, 1, 1, 1)
    UpdateItemList(DLC1VendorElvenArrows, MEKCAElvenChairrow, 1, 200, 1)
    UpdateItemList(DLC1LootElvenArrows25, MEKCAElvenChairrow, 1, 6, 1)

    UpdateItemList(SublistThalmorArrowsGlass, MEKCAGlassChairrow, 1, 6, 1)
    UpdateItemList(BaseArrowGlass75, MEKCAGlassChairrow, 1, 1, 1)

    UpdateItemList(BaseArrowEbony75, MEKCAEbonyChairrow, 1, 1, 1)
    UpdateItemList(LItemDraugr05EWeaponArrowSublist, MEKCAEbonyChairrow, 1, 1, 1)

    UpdateItemList(BaseArrowDaedric75, MEKCADaedricChairrow, 1, 1, 1)
    UpdateItemList(DLC1LootDragonDaedricArrows, MEKCADaedricChairrow, 1, 6, 1)
    Debug.Trace(LogPrefix + "==========Base Game Leveled Lists Updated==========")

    Debug.Trace(LogPrefix + "==========Updating Base Game Form Lists============")
    UpdateFormList(ArrowTypeFormList, MEKCAChairrowIronProjectile)
    UpdateFormList(ArrowTypeFormList, MEKCAChairrowSteelProjectile)
    UpdateFormList(ArrowTypeFormList, MEKCAChairrowOrcishProjectile)
    UpdateFormList(ArrowTypeFormList, MEKCAChairrowDwarvenProjectile)
    UpdateFormList(ArrowTypeFormList, MEKCAChairrowElvenProjectile)
    UpdateFormList(ArrowTypeFormList, MEKCAChairrowGlassProjectile)
    UpdateFormList(ArrowTypeFormList, MEKCAChairrowEbonyProjectile)
    UpdateFormList(ArrowTypeFormList, MEKCAChairrowDaedricProjectile)

    UpdateFormList(DLC1DBDunStatueArrowList, MEKCAChairrowIronProjectile)
    UpdateFormList(DLC1DBDunStatueArrowList, MEKCAChairrowSteelProjectile)
    UpdateFormList(DLC1DBDunStatueArrowList, MEKCAChairrowOrcishProjectile)
    UpdateFormList(DLC1DBDunStatueArrowList, MEKCAChairrowDwarvenProjectile)
    UpdateFormList(DLC1DBDunStatueArrowList, MEKCAChairrowElvenProjectile)
    UpdateFormList(DLC1DBDunStatueArrowList, MEKCAChairrowGlassProjectile)
    UpdateFormList(DLC1DBDunStatueArrowList, MEKCAChairrowEbonyProjectile)
    UpdateFormList(DLC1DBDunStatueArrowList, MEKCAChairrowDaedricProjectile)
    Debug.Trace(LogPrefix + "==========Base Game Form Lists Updated=============")
EndFunction

Function UpdateValdacilsItemSorting2_0()
    If (Game.GetModByName(ValdacilsItemSorting) == 255)
        Return
    EndIf

    Debug.Trace(LogPrefix + "Valdacil's Item Sorting Detected. Updating Weapon Names")
    RenameWeaponValdacilsItemSorting(MEKCAIronChairrow)
    RenameWeaponValdacilsItemSorting(MEKCASteelChairrow)
    RenameWeaponValdacilsItemSorting(MEKCAOrcishChairrow)
    RenameWeaponValdacilsItemSorting(MEKCADwarvenChairrow)
    RenameWeaponValdacilsItemSorting(MEKCAElvenChairrow)
    RenameWeaponValdacilsItemSorting(MEKCAGlassChairrow)
    RenameWeaponValdacilsItemSorting(MEKCAEbonyChairrow)
    RenameWeaponValdacilsItemSorting(MEKCADaedricChairrow)
    Debug.Trace(LogPrefix + "Valdacil's Item Sorting Names Set")
EndFunction