include "constants.asm"

item_attribute: MACRO
; price, held effect, parameter, property, pocket, field menu, battle menu
        dw \1
        db \2, \3, \4, \5
        dn \6, \7
ENDM

SECTION "Item Attributes", ROMX [$68f3], BANK [$01]

ItemAttributes:: ; 68f3
; ITEM_MASTER_BALL
	item_attribute 0, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_CLOSE
; ITEM_ULTRA_BALL
	item_attribute 1200, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_CLOSE
; ITEM_03
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_GREAT_BALL
	item_attribute 600, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_CLOSE
; ITEM_POKE_BALL
	item_attribute 200, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_CLOSE
; ITEM_TOWN_MAP
	item_attribute 0, 0, 0, CANT_TOSS, KEY_ITEM, ITEMMENU_CLOSE, ITEMMENU_NOUSE
; ITEM_BICYCLE
	item_attribute 0, 0, 0, CANT_TOSS, KEY_ITEM, ITEMMENU_CLOSE, ITEMMENU_NOUSE
; ITEM_MOON_STONE
	item_attribute 0, 0, 0, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_NOUSE
; ITEM_ANTIDOTE
	item_attribute 100, 10, 0, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_BURN_HEAL
	item_attribute 250, 11, 0, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_ICE_HEAL
	item_attribute 250, 12, 0, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_AWAKENING
	item_attribute 250, 13, 0, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_PARLYZ_HEAL
	item_attribute 200, 14, 0, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_FULL_RESTORE
	item_attribute 3000, 2, 255, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_MAX_POTION
	item_attribute 2500, 1, 255, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_HYPER_POTION
	item_attribute 1200, 1, 200, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_SUPER_POTION
	item_attribute 700, 1, 50, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_POTION
	item_attribute 300, 1, 20, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_ESCAPE_ROPE
	item_attribute 550, 0, 0, CANT_SELECT, ITEM, ITEMMENU_CLOSE, ITEMMENU_NOUSE
; ITEM_REPEL
	item_attribute 350, 0, 0, CANT_SELECT, ITEM, ITEMMENU_CURRENT, ITEMMENU_NOUSE
; ITEM_MAX_ELIXER
	item_attribute 4800, 7, 255, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_FIRE_STONE
	item_attribute 2100, 0, 0, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_NOUSE
; ITEM_THUNDERSTONE
	item_attribute 2100, 0, 0, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_NOUSE
; ITEM_WATER_STONE
	item_attribute 2100, 0, 0, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_NOUSE
; ITEM_19
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_HP_UP
	item_attribute 9800, 0, 0, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_NOUSE
; ITEM_PROTEIN
	item_attribute 9800, 0, 0, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_NOUSE
; ITEM_IRON
	item_attribute 9800, 0, 0, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_NOUSE
; ITEM_CARBOS
	item_attribute 9800, 0, 0, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_NOUSE
; ITEM_1E
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_CALCIUM
	item_attribute 9800, 0, 0, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_NOUSE
; ITEM_RARE_CANDY
	item_attribute 4800, 0, 0, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_NOUSE
; ITEM_X_ACCURACY
	item_attribute 950, 36, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_CLOSE
; ITEM_LEAF_STONE
	item_attribute 2100, 0, 0, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_NOUSE
; ITEM_23
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_NUGGET
	item_attribute 10000, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_POKE_DOLL
	item_attribute 1000, 72, 0, CANT_SELECT, ITEM, ITEMMENU_CLOSE, ITEMMENU_NOUSE
; ITEM_FULL_HEAL
	item_attribute 600, 15, 0, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_REVIVE
	item_attribute 1500, 5, 50, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_MAX_REVIVE
	item_attribute 4000, 5, 100, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_GUARD_SPEC
	item_attribute 700, 35, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_CLOSE
; ITEM_SUPER_REPEL
	item_attribute 500, 0, 0, CANT_SELECT, ITEM, ITEMMENU_CURRENT, ITEMMENU_NOUSE
; ITEM_MAX_REPEL
	item_attribute 700, 0, 0, CANT_SELECT, ITEM, ITEMMENU_CURRENT, ITEMMENU_NOUSE
; ITEM_DIRE_HIT
	item_attribute 650, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_CLOSE
; ITEM_2D
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_FRESH_WATER
	item_attribute 200, 1, 50, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_SODA_POP
	item_attribute 300, 1, 60, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_LEMONADE
	item_attribute 350, 1, 80, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_X_ATTACK
	item_attribute 500, 31, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_CLOSE
; ITEM_32
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_X_DEFEND
	item_attribute 550, 32, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_CLOSE
; ITEM_X_SPEED
	item_attribute 350, 33, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_CLOSE
; ITEM_X_SPECIAL
	item_attribute 350, 34, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_CLOSE
; ITEM_COIN_CASE
	item_attribute 0, 0, 0, CANT_TOSS, KEY_ITEM, ITEMMENU_CURRENT, ITEMMENU_NOUSE
; ITEM_ITEMFINDER
	item_attribute 0, 0, 0, CANT_TOSS, KEY_ITEM, ITEMMENU_CLOSE, ITEMMENU_NOUSE
; ITEM_POKE_FLUTE
	item_attribute 0, 0, 0, CANT_SELECT | CANT_TOSS, KEY_ITEM, ITEMMENU_CLOSE, ITEMMENU_CURRENT
; ITEM_EXP_SHARE
	item_attribute 0, 0, 0, CANT_SELECT | CANT_TOSS, KEY_ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_OLD_ROD
	item_attribute 0, 0, 0, CANT_TOSS, KEY_ITEM, ITEMMENU_CLOSE, ITEMMENU_NOUSE
; ITEM_GOOD_ROD
	item_attribute 0, 0, 0, CANT_TOSS, KEY_ITEM, ITEMMENU_CLOSE, ITEMMENU_NOUSE
; ITEM_3C
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_SUPER_ROD
	item_attribute 0, 0, 0, CANT_TOSS, KEY_ITEM, ITEMMENU_CLOSE, ITEMMENU_NOUSE
; ITEM_PP_UP
	item_attribute 9800, 0, 0, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_NOUSE
; ITEM_ETHER
	item_attribute 1200, 6, 10, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_MAX_ETHER
	item_attribute 2400, 6, 255, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_ELIXER
	item_attribute 2400, 7, 10, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_MYSTIC_PETAL
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_WHITE_FEATHER
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_CONFUSE_CLAW
	item_attribute 10, 78, 15, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_WISDOM_ORB
	item_attribute 10, 45, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_STEEL_SHELL
	item_attribute 10, 42, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_UP_GRADE
	item_attribute 10, 48, 10, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_STRANGE_THREAD
	item_attribute 10, 77, 30, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_BIG_LEAF
	item_attribute 10, 60, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_QUICK_NEEDLE
	item_attribute 10, 74, 30, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_4B
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_SHARP_STONE
	item_attribute 10, 55, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_BLACK_FEATHER
	item_attribute 10, 52, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_SHARP_FANG
	item_attribute 10, 50, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_SNAKESKIN
	item_attribute 10, 20, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_ELECTRIC_POUCH
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_TOXIC_NEEDLE
	item_attribute 10, 53, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_KINGS_ROCK
	item_attribute 10, 75, 30, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_STRANGE_POWER
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_LIFE_TAG
	item_attribute 10, 4, 1, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_POISON_FANG
	item_attribute 10, 53, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_CORDYCEPS
	item_attribute 10000, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_DRAGON_FANG
	item_attribute 10, 64, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_SILVERPOWDER
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_DIGGING_CLAW
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_5A
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_AMULET_COIN
	item_attribute 10, 76, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_MIGRAINE_SEED
	item_attribute 10, 62, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_COUNTER_CUFF
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_TALISMAN_TAG
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_STRANGE_WATER
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_TWISTEDSPOON
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_ATTACK_NEEDLE
	item_attribute 10, 56, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_POWER_BRACER
	item_attribute 10, 51, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_HARD_STONE
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_64
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_JIGGLING_BALLOON
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_FIRE_MANE
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_SLOWPOKETAIL
	item_attribute 10000, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_EARTH
	item_attribute 10, 24, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_STICK
	item_attribute 10, 50, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_FLEE_FEATHER
	item_attribute 10, 71, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_ICE_FANG
	item_attribute 10, 63, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_FOSSIL_SHARD
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_GROSS_GARBAGE
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_BIG_PEARL
	item_attribute 15000, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_CHAMPION_BELT
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_TAG
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_SPELL_TAG
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_5_YEN_COIN
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_GUARD_THREAD
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_STIMULUS_ORB
	item_attribute 10, 23, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_CALM_BERRY
	item_attribute 10, 25, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_THICK_CLUB
	item_attribute 10, 54, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_FOCUS_ORB
	item_attribute 10, 79, 30, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_78
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_DETECT_ORB
	item_attribute 10, 37, 30, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_LONG_TONGUE
	item_attribute 10, 70, 10, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_LOTTO_TICKET
	item_attribute 10, 0, 0, CANT_SELECT | CANT_TOSS, KEY_ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_EVERSTONE
	item_attribute 0, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_SHARP_HORN
	item_attribute 10, 41, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_LUCKY_EGG
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_LONG_VINE
	item_attribute 10, 70, 10, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_MOMS_LOVE
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_SMOKESCREEN
	item_attribute 10, 72, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_WET_HORN
	item_attribute 10, 59, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_SKATEBOARD
	item_attribute 0, 0, 0, CANT_TOSS, KEY_ITEM, ITEMMENU_CLOSE, ITEMMENU_NOUSE
; ITEM_CRIMSON_JEWEL
	item_attribute 12000, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_INVISIBLE_WALL
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_SHARP_SCYTHE
	item_attribute 10, 73, 30, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_87
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_ICE_BIKINI
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_THUNDER_FANG
	item_attribute 10, 61, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_FIRE_CLAW
	item_attribute 10, 58, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_TWIN_HORNS
	item_attribute 10, 41, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_SPIKE
	item_attribute 10, 57, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_BERRY
	item_attribute 100, 1, 20, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_APPLE
	item_attribute 300, 1, 50, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_METAL_COAT
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_PRETTY_TAIL
	item_attribute 10, 20, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_WATER_TAIL
	item_attribute 10, 21, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_LEFTOVERS
	item_attribute 10, 3, 30, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_ICE_WING
	item_attribute 10, 45, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_THUNDER_WING
	item_attribute 10, 43, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_FIRE_WING
	item_attribute 10, 34, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_96
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_DRAGON_SCALE
	item_attribute 10, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_BERSERK_GENE
	item_attribute 10, 48, 20, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_HEART_STONE
	item_attribute 2100, 0, 0, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_NOUSE
; ITEM_FIRE_TAIL
	item_attribute 10, 22, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_THUNDER_TAIL
	item_attribute 10, 24, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_SACRED_ASH
	item_attribute 10, 5, 255, CANT_SELECT, ITEM, ITEMMENU_CLOSE, ITEMMENU_CLOSE
; ITEM_TM_HOLDER
	item_attribute 0, 0, 0, CANT_SELECT | CANT_TOSS, ITEM, 1, 1
; ITEM_MAIL
	item_attribute 0, 0, 0, CANT_SELECT, ITEM, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_BALL_HOLDER
	item_attribute 0, 0, 0, CANT_SELECT | CANT_TOSS, ITEM, 2, 2
; ITEM_BAG
	item_attribute 0, 0, 0, CANT_SELECT | CANT_TOSS, KEY_ITEM, 3, 3
; ITEM_IMPORTANT_BAG
	item_attribute 0, 0, 0, CANT_SELECT | CANT_TOSS, ITEM, 3, 3
; ITEM_POISON_STONE
	item_attribute 2100, 0, 0, CANT_SELECT, ITEM, ITEMMENU_PARTY, ITEMMENU_NOUSE
; ITEM_A3
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_A4
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_A5
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_A6
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_A7
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_A8
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_A9
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_AA
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_AB
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_AC
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_AD
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_AE
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_AF
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_B0
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_B1
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_B2
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_B3
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_B4
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_B5
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_B6
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_B7
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_B8
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_B9
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_BA
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_BB
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_BC
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_BD
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_BE
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_BF
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_C0
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_C1
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_C2
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_C3
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_TM01
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM02
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM03
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM04
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_C8
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_TM05
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM06
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM07
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM08
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM09
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM10
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM11
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM12
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM13
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM14
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM15
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM16
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM17
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM18
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM19
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM20
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM21
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM22
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM23
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM24
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM25
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM26
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM27
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM28
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_E1
	item_attribute 0, 0, 0, NO_LIMITS, 0, ITEMMENU_NOUSE, ITEMMENU_NOUSE
; ITEM_TM29
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM30
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM31
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM32
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM33
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM34
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM35
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM36
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM37
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM38
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM39
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM40
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM41
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM42
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM43
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM44
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM45
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM46
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM47
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM48
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM49
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_TM50
	item_attribute 1000, 0, 0, CANT_SELECT, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_HM01
	item_attribute 0, 0, 0, CANT_SELECT | CANT_TOSS, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_HM02
	item_attribute 0, 0, 0, CANT_SELECT | CANT_TOSS, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_HM03
	item_attribute 0, 0, 0, CANT_SELECT | CANT_TOSS, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_HM04
	item_attribute 0, 0, 0, CANT_SELECT | CANT_TOSS, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_HM05
	item_attribute 0, 0, 0, CANT_SELECT | CANT_TOSS, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_HM06
	item_attribute 0, 0, 0, CANT_SELECT | CANT_TOSS, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
; ITEM_HM07
	item_attribute 0, 0, 0, CANT_SELECT | CANT_TOSS, TM_HM, ITEMMENU_PARTY, ITEMMENU_PARTY
