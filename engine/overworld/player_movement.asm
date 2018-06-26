INCLUDE "constants.asm"

SECTION "Player Movement", ROMX[$4000], BANK[$3]

OverworldMovementCheck:: ; 03:4000
	jp _OverworldMovementCheck

UnusedOverworldMovementCheck:: ; 03:4003
	ld a, PLAYER_OBJECT_INDEX
	ldh [hEventCollisionException], a
	ld a, [wPlayerDirection]
	and a
	jr z, SetPlayerIdle ; player movement is disabled
	ldh a, [hJoyState]
	ld d, a
	ld hl, wce63
	bit 1, [hl]
	jr z, .skip_debug_move
	bit B_BUTTON_F, d
	jp nz, CheckMovementDebug
.skip_debug_move
	ld a, [wPlayerState]
	cp PLAYER_SKATE
	jp z, CheckMovementSkateboard
	cp PLAYER_SURF
	jp z, OldCheckMovementSurf
	jp CheckMovementWalkOrBike

SetPlayerIdle: ; 03:402c
	ld a, NO_MOVEMENT
	
SetPlayerMovement: ; 03:402e
	ld [wPlayerMovement], a
	ld a, [wPlayerLastMapX]
	ld [wPlayerNextMapX], a
	ld a, [wPlayerLastMapY]
	ld [wPlayerNextMapY], a
	and a
	ret

CheckMovementWalkOrBike: ; 03:403f
	call _CheckMovementWalkOrBike
	jp SetPlayerMovement

_CheckMovementWalkOrBike: ; 03:4045
	ld a, d
	and D_PAD
	jp z, .idle
	ld a, d
	bit D_DOWN_F, a
	jp nz, .check_down
	bit D_UP_F, a
	jp nz, .check_up
	bit D_LEFT_F, a
	jp nz, .check_left
	bit D_RIGHT_F, a
	jr nz, .check_right
.idle
	ld a, NO_MOVEMENT
	ret
	
.check_right
	ld a, [wPlayerLastMapX]
	inc a
	ld [wPlayerNextMapX], a
	call CheckPlayerObjectCollision
	jr c, .face_right
	call IsPlayerCollisionTileSolid
	jr nc, .move_right
	jr .face_right
.move_right
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	ld a, FAST_STEP_RIGHT
	ret z
	ld a, STEP_RIGHT
	ret
.face_right
	ld a, FACE_RIGHT
	ret

.check_left:
	ld a, [wPlayerLastMapX]
	dec a
	ld [wPlayerNextMapX], a
	call CheckPlayerObjectCollision
	jr c, .face_left
	call IsPlayerCollisionTileSolid
	jr nc, .move_left
	jr .face_left
.move_left
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	ld a, FAST_STEP_LEFT
	ret z
	ld a, STEP_LEFT
	ret
.face_left
	ld a, FACE_LEFT
	ret

.check_down
	ld a, [wPlayerLastMapY]
	inc a
	ld [wPlayerNextMapY], a
	call CheckPlayerObjectCollision
	jr c, .face_down
	call IsPlayerCollisionTileSolid
	jr nc, .move_down
	cp OLD_COLLISION_LEDGE
	jr nz, .face_down
	ld a, JUMP_DOWN
	ret
.move_down
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	ld a, FAST_STEP_DOWN
	ret z
	ld a, STEP_DOWN
	ret
.face_down
	ld a, FACE_DOWN
	ret

.check_up
	ld a, [wPlayerLastMapY]
	dec a
	ld [wPlayerNextMapY], a
	call CheckPlayerObjectCollision
	jr c, .face_up
	call IsPlayerCollisionTileSolid
	jr nc, .move_up
	jr .face_up
.move_up
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	ld a, FAST_STEP_UP
	ret z
	ld a, STEP_UP
	ret
.face_up
	ld a, FACE_UP
	ret

CheckMovementDebug:: ; 03:40eb
	ld a, d
	call _CheckMovementDebug
	jp SetPlayerMovement

_CheckMovementDebug: ; 03:40f2
	bit D_DOWN_F, a
	jr nz, .move_down
	bit D_UP_F, a
	jr nz, .move_up
	bit D_LEFT_F, a
	jr nz, .move_left
	bit D_RIGHT_F, a
	jr nz, .move_right
	ld a, NO_MOVEMENT
	ret
	
.move_down
	ld a, [wTileDown]
	cp -1
	ld a, FAST_STEP_DOWN
	ret nz
	ld a, JUMP_UP
	ret
	
.move_up
	ld a, [wTileUp]
	cp -1
	ld a, FAST_STEP_UP
	ret nz
	ld a, JUMP_DOWN
	ret
	
.move_left
	ld a, [wTileLeft]
	cp -1
	ld a, FAST_STEP_LEFT
	ret nz
	ld a, JUMP_RIGHT
	ret
	
.move_right
	ld a, [wTileRight]
	cp -1
	ld a, FAST_STEP_RIGHT
	ret nz
	ld a, JUMP_LEFT
	ret

CheckMovementSkateboard:: ; 03:4131
	call _CheckMovementSkateboard
	jp SetPlayerMovement

_CheckMovementSkateboard:  ; 03:4137
	ld a, [wSkatingDirection]
	cp STANDING
	jp z, .not_moving
	push de
	ld e, a
	ld d, $00
	ld hl, .SkateMovementTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop de
	jp hl

.SkateMovementTable ; 03:414d
	dw CheckSkateDown
	dw CheckSkateUp
	dw CheckSkateLeft
	dw CheckSkateRight

.not_moving  ; 03:4155
	ld a, d
	and D_PAD
	jp z, .idle
	bit D_DOWN_F, d
	jp nz, CheckSkateDown
	bit D_UP_F, d
	jp nz, CheckSkateUp
	bit D_LEFT_F, d
	jp nz, CheckSkateLeft
	bit D_RIGHT_F, d
	jp nz, CheckSkateRight

.idle
	ld a, STANDING
	ld [wSkatingDirection], a
	ld a, NO_MOVEMENT
	ret

CheckSkateDown:  ; 03:4177
	ld a, [wPlayerLastMapY]
	inc a
	ld [wPlayerNextMapY], a
	ld a, DOWN
	ld [wSkatingDirection], a
	call CheckPlayerObjectCollision
	jr c, .collision
	call IsPlayerCollisionTileSolid
	jr nc, .can_skate
	cp OLD_COLLISION_LEDGE
	jr z, .jump
	cp (OLD_COLLISION_ROCK | COLLISION_FLAG)
	jr nz, .collision

.jump
	ld a, FAST_JUMP_DOWN
	ret

.can_skate
	call OldIsTileCollisionGrass
	jr z, .slow
	ld a, FAST_STEP_DOWN
	ret
	
.slow
	ld a, STEP_DOWN
	ret
	
.collision
	ld a, STANDING
	ld [wSkatingDirection], a
	ld a, FACE_DOWN
	ret

CheckSkateUp: ; 03:41ab
	ld a, [wPlayerLastMapY]
	dec a
	ld [wPlayerNextMapY], a
	ld a, UP
	ld [wSkatingDirection], a
	call CheckPlayerObjectCollision
	jr c, .collision
	call IsPlayerCollisionTileSolid
	jr nc, .can_skate
	cp (OLD_COLLISION_ROCK | COLLISION_FLAG)
	jr nz, .collision
	ld a, FAST_JUMP_UP
	ret
	
.can_skate
	call OldIsTileCollisionGrass
	jr z, .slow
	ld a, FAST_STEP_UP
	ret
	
.slow
	ld a, STEP_UP
	ret
	
.collision
	ld a, STANDING
	ld [wSkatingDirection], a
	ld a, FACE_UP
	ret

CheckSkateLeft: ; 03:41db
	ld a, [wPlayerLastMapX]
	dec a
	ld [wPlayerNextMapX], a
	ld a, LEFT
	ld [wSkatingDirection], a
	call CheckPlayerObjectCollision
	jr c, .collision
	call IsPlayerCollisionTileSolid
	jr nc, .can_skate
	cp (OLD_COLLISION_ROCK | COLLISION_FLAG)
	jr nz, .collision
	ld a, FAST_JUMP_LEFT
	ret
	
.can_skate
	call OldIsTileCollisionGrass
	jr z, .slow
	ld a, FAST_STEP_LEFT
	ret

.slow
	ld a, STEP_LEFT
	ret
	
.collision
	ld a, STANDING
	ld [wSkatingDirection], a
	ld a, FACE_LEFT
	ret

CheckSkateRight: ; 03:420b
	ld a, [wPlayerLastMapX]
	inc a
	ld [wPlayerNextMapX], a
	ld a, RIGHT
	ld [wSkatingDirection], a
	call CheckPlayerObjectCollision
	jr c, .collision
	call IsPlayerCollisionTileSolid
	jr nc, .can_skate
	cp (OLD_COLLISION_ROCK | COLLISION_FLAG)
	jr nz, .collision
	ld a, FAST_JUMP_RIGHT
	ret

.can_skate
	call OldIsTileCollisionGrass
	jr z, .slow
	ld a, FAST_STEP_RIGHT
	ret

.slow
	ld a, STEP_RIGHT
	ret
	
.collision
	ld a, STANDING
	ld [wSkatingDirection], a
	ld a, FACE_RIGHT
	ret

OldIsTileCollisionGrass:: ; 03:423b
; Check whether collision ID in a is
; grass
; Result:
; nz - not grass
;  z - grass
	cp $82
	ret z
	cp $83
	ret z
	cp $8a
	ret z
	cp $8b
	ret

OldCheckMovementSurf:: ; 03:4247
	call _OldCheckMovementSurf
	jp SetPlayerMovement

_OldCheckMovementSurf: ; 03:424d
	ld a, d
	and D_PAD
	bit D_DOWN_F, a
	jp nz, .check_down
	bit D_UP_F, a
	jp nz, .check_up
	bit D_LEFT_F, a
	jp nz, .check_left
	bit D_RIGHT_F, a
	jr nz, .check_right
	ld a, NO_MOVEMENT
	ret

.check_down
	ld a, [wPlayerLastMapY]
	inc a
	ld [wPlayerNextMapY], a
	call CheckPlayerObjectCollision
	jr c, .face_down
	call IsPlayerCollisionTileSolid
	jr nc, .exit_water_down ; FIXME: This assumes cut-trees are solid, which they aren't.
	                        ;        You can walk into them from water because of this.
	call OldIsTileCollisionWater
	jr c, .face_down
	ld a, STEP_DOWN
	ret
.face_down
	ld a, FACE_DOWN
	ret
.exit_water_down
	call SetPlayerStateWalk
	ld a, SLOW_STEP_DOWN
	ret

.check_up
	ld a, [wPlayerLastMapY]
	dec a
	ld [wPlayerNextMapY], a
	call CheckPlayerObjectCollision
	jr c, .face_up
	call IsPlayerCollisionTileSolid
	jr nc, .exit_water_up ; FIXME: This assumes cut-trees are solid, which they aren't.
	                      ;        You can walk into them from water because of this.
	call OldIsTileCollisionWater
	jr c, .face_up
	ld a, STEP_UP
	ret
.face_up
	ld a, FACE_UP
	ret
.exit_water_up
	call SetPlayerStateWalk
	ld a, SLOW_STEP_UP
	ret

.check_left
	ld a, [wPlayerLastMapX]
	dec a
	ld [wPlayerNextMapX], a
	call CheckPlayerObjectCollision
	jr c, .face_left
	call IsPlayerCollisionTileSolid
	jr nc, .exit_water_left ; FIXME: This assumes cut-trees are solid, which they aren't.
	                        ;        You can walk into them from water because of this.
	call OldIsTileCollisionWater
	jr c, .face_left
	ld a, STEP_LEFT
	ret
.face_left
	ld a, FACE_LEFT
	ret
.exit_water_left
	call SetPlayerStateWalk
	ld a, SLOW_STEP_LEFT
	ret

.check_right
	ld a, [wPlayerLastMapX]
	inc a
	ld [wPlayerNextMapX], a
	call CheckPlayerObjectCollision
	jr c, .face_right
	call IsPlayerCollisionTileSolid
	jr nc, .exit_water_right ; FIXME: This assumes cut-trees are solid, which they aren't.
	                      ;        You can walk into them from water because of this.
	call OldIsTileCollisionWater
	jr c, .face_right
	ld a, STEP_RIGHT
	ret
.face_right
	ld a, FACE_RIGHT
	ret
.exit_water_right
	call SetPlayerStateWalk
	ld a, SLOW_STEP_RIGHT
	ret

OldIsTileCollisionWater:: ; 03:42ee
; Check if collision ID in a is water
; Input:
; a - collision ID
; Result:
;  c - water
; nc - not water
	and COLLISION_TYPE_MASK
	cp OLD_COLLISION_TYPE_WATER
	ret z
	cp OLD_COLLISION_TYPE_WATER2
	ret z
	scf
	ret

SetPlayerStateWalk:: ; 03:42f8
	push bc
	ld a, PLAYER_NORMAL
	ld [wPlayerState], a
	call RedrawPlayerSprite
	pop bc
	ret

IsPlayerCollisionTileSolid:: ; 03:4303
; Return whether the collision under player's feet
; is solid/sometimes solid or non-solid.
; Clobbers: a
; Results:
;  a - collision ID under player's feet
; nc - non-solid
;  c - solid/sometimes solid
	push de
	ld bc, wPlayerStruct
	callab _IsObjectCollisionTileSolid
	ld a, e
	pop de
	ret

CheckPlayerObjectCollision:: ; 03:4312
; Check whether player object currentl
; collides with any other object.
; Result:
; nc - no collision
;  c - collision
	push de
	callab _CheckPlayerObjectCollision
	pop de
	ret nc
	jp CheckCompanionObjectCollision

CheckCompanionObjectCollision:: ; 03:4320
; Marks the object struct pointed to by hl
; as having collided with player object.
; If object struct (as identified by hObjectStructIndexBuffer)
; is companion, cancel collision on 5th frames.
; Result:
; nc - no collision
;  c - collision
	ld hl, OBJECT_FLAGS + 1
	add hl, bc
	set 1, [hl] ; mark object as having collided with player
	ldh a, [hObjectStructIndexBuffer]
	cp COMPANION_OBJECT_INDEX
	jr z, .is_companion
	xor a
	ld [wCompanionCollisionFrameCounter], a
	scf
	ret
.is_companion
	ld a, [wCompanionCollisionFrameCounter]
	inc a
	cp 5
	ld [wCompanionCollisionFrameCounter], a
	jr z, .cancel_collision
	scf
	ret
.cancel_collision
	xor a
	ld [wCompanionCollisionFrameCounter], a
	ret

_OverworldMovementCheck:: ; 03:4344
	ld a, PLAYER_OBJECT_INDEX
	ldh [hEventCollisionException], a
	ld a, [wPlayerDirection]
	and a
	jp z, SetPlayerIdle
	ldh a, [hJoyState]
	ld d, a
	ld hl, wce63
	bit 1, [hl]
	jr z, .skip_debug_move
	bit B_BUTTON_F, d
	jp nz, CheckMovementDebug

.skip_debug_move
	call GetPlayerMovementByState
	jp SetPlayerMovement

GetPlayerMovementByState: ; 03:4364
	ld a, [wPlayerState]
	cp PLAYER_SKATE
	jp z, CheckMovementSkateboard ; FIXME: CheckMovementSkateboard already calls SetPlayerMovement
	                                 ;        The skateboard doesn't work, because it uses the current
	                                 ;        coordinate as player animation.
	cp PLAYER_SURF
	jp z, CheckMovementSurf
	jp CheckMovementWalk

CheckMovementWalk:: ; 03:4374
	ld a, [wPlayerStandingTile]
	swap a
	and LOW((COLLISION_TYPE_MASK >> 4) | (COLLISION_TYPE_MASK << 4))
	ld hl, .WalkingCollisionTable
	jp CallJumptable

.WalkingCollisionTable ; 03:4381
	dw CheckMovementWalkRegular ; regular
	dw CheckMovementWalkSolid   ; trees, grass, etc.
	dw CheckMovementWalkSolid   ; water
	dw CheckMovementWalkSolid   ; water current
	dw CheckMovementWalkLand    ; slowdown and fixed movement
	dw CheckMovementWalkLand2   ; fixed movement
	dw CheckMovementWalkRegular ; ???
	dw CheckMovementWalkWarp    ; warps
	dw CheckMovementWalkMisc    ; ???
	dw CheckMovementWalkSpecial ; counters, signposts, book cases
	dw CheckMovementWalkJump    ; jumps
	dw CheckMovementWalkRegular ; unused -- movement prohibit not yet implemented
	dw CheckMovementWalkRegular ; unused
	dw CheckMovementWalkRegular ; unused
	dw CheckMovementWalkRegular ; unused
	dw CheckMovementWalkRegular ; unused

NoWalkMovement: ; 03:43a1
	ld a, NO_MOVEMENT
	ret

CheckMovementWalkSolid:: ; 03:43a4
	jp CheckMovementWalkRegular

CheckMovementWalkLand:: ; 03:43a7
	ld a, [wPlayerStandingTile]
	and COLLISION_SUBTYPE_MASK
	jr nz, .force_movement
	call CheckMovementWalkRegular
	call SlowDownMovementWalk
	ret

.force_movement
	ld b, STEP_DOWN
	cp (COLLISION_LAND_S & COLLISION_SUBTYPE_MASK)
	jr z, .finish
	ld b, STEP_UP
	cp (COLLISION_LAND_N & COLLISION_SUBTYPE_MASK)
	jr z, .finish
	ld b, STEP_LEFT
	cp (COLLISION_LAND_W & COLLISION_SUBTYPE_MASK)
	jr z, .finish
	ld b, STEP_RIGHT
	cp (COLLISION_LAND_E & COLLISION_SUBTYPE_MASK)
	jr z, .finish
	; fall-through --> map other codes to COLLISION_LAND_E
.finish
	ld a, b
	ret

SlowDownMovementWalk: ; 03:43cf
	ld b, SLOW_STEP_DOWN
	cp STEP_DOWN
	jr z, .finish
	ld b, SLOW_STEP_UP
	cp STEP_UP
	jr z, .finish
	ld b, SLOW_STEP_LEFT
	cp STEP_LEFT
	jr z, .finish
	ld b, SLOW_STEP_RIGHT
	cp STEP_RIGHT
	jr z, .finish
	ret
.finish
	ld a, b
	ret

CheckMovementWalkLand2:: ; 03:43ea
	ld a, [wPlayerStandingTile]
	and COLLISION_SUBTYPE_MASK
	ld b, STEP_DOWN
	cp (COLLISION_LAND2_S & COLLISION_SUBTYPE_MASK)
	jr z, .finish
	ld b, STEP_UP
	cp (COLLISION_LAND2_N & COLLISION_SUBTYPE_MASK)
	jr z, .finish
	ld b, STEP_LEFT
	cp (COLLISION_LAND2_W & COLLISION_SUBTYPE_MASK)
	jr z, .finish
	ld b, STEP_RIGHT
	cp (COLLISION_LAND2_E & COLLISION_SUBTYPE_MASK)
	jr z, .finish
	; fall-through --> map other codes to COLLISION_LAND2_E
.finish
	ld a, b
	ret

UnusedCheckMovementWalk60:: ; 03:4409
	jp CheckMovementWalkRegular

CheckMovementWalkWarp:: ; 03:440c
	ld a, [wPlayerStandingTile]
	and COLLISION_SUBTYPE_MASK
	jr z, .check_dpad
	cp 1
	jr z, .move_down
	ld a, [wPlayerStandingTile]
	cp $7a
	jr z, .move_down
	jp CheckMovementWalkRegular
.move_down
	ld a, STEP_DOWN
	ret

.check_dpad
	ldh a, [hJoyState]
	bit D_DOWN_F, a
	jr nz, .down
	bit D_UP_F, a
	jr nz, .up
	bit D_LEFT_F, a
	jr nz, .left
	bit D_RIGHT_F, a
	jr nz, .right
	jp NoWalkMovement

.down
	ld a, [wTileDown]
	cp -1
	jp nz, CheckMovementWalkRegular
	call z, .moved_out_of_bounds
	ld a, FACE_DOWN
	ret
.up
	ld a, [wTileUp]
	cp -1
	jp nz, CheckMovementWalkRegular
	call z, .moved_out_of_bounds
	ld a, FACE_UP
	ret
.left
	ld a, [wTileLeft]
	cp -1
	jp nz, CheckMovementWalkRegular
	call z, .moved_out_of_bounds
	ld a, FACE_LEFT
	ret
.right
	ld a, [wTileRight]
	cp -1
	jp nz, CheckMovementWalkRegular
	call z, .moved_out_of_bounds
	ld a, FACE_RIGHT
	ret

.moved_out_of_bounds
	ret

CheckMovementWalkMisc:: ; 03:4472
	jp CheckMovementWalkRegular

CheckMovementWalkSpecial:: ; 03:4475
	jp CheckMovementWalkRegular

CheckMovementWalkRegular:: ; 03:4478
	ldh a, [hJoyState]
	bit D_DOWN_F, a
	jp nz, CheckWalkDown
	bit D_UP_F, a
	jp nz, CheckWalkUp
	bit D_LEFT_F, a
	jp nz, CheckWalkLeft
	bit D_RIGHT_F, a
	jp nz, CheckWalkRight
	jp NoWalkMovement

CheckMovementWalkJump: ; 03:4491
	ldh a, [hJoyState]
	bit D_DOWN_F, a
	jr nz, .down
	bit D_UP_F, a
	jr nz, .up
	bit D_LEFT_F, a
	jr nz, .left
	bit D_RIGHT_F, a
	jr nz, .right
	jp NoWalkMovement

.down
	ld a, [wPlayerStandingTile]
	and COLLISION_SUBTYPE_MASK
	cp (COLLISION_JUMP_S & COLLISION_SUBTYPE_MASK)
	jr z, .jump_down
	cp (COLLISION_JUMP_SE & COLLISION_SUBTYPE_MASK)
	jr z, .jump_down
	cp (COLLISION_JUMP_SW & COLLISION_SUBTYPE_MASK)
	jr z, .jump_down
	jp CheckWalkDown
.jump_down
	ld a, JUMP_DOWN
	ret

.up
	ld a, [wPlayerStandingTile]
	and COLLISION_SUBTYPE_MASK
	cp (COLLISION_JUMP_N & COLLISION_SUBTYPE_MASK)
	jr z, .jump_up
	cp (COLLISION_JUMP_NE & COLLISION_SUBTYPE_MASK)
	jr z, .jump_up
	cp (COLLISION_JUMP_NW & COLLISION_SUBTYPE_MASK)
	jr z, .jump_up
	jp CheckWalkUp
.jump_up
	ld a, JUMP_UP
	ret

.left
	ld a, [wPlayerStandingTile]
	and COLLISION_SUBTYPE_MASK
	cp (COLLISION_JUMP_W & COLLISION_SUBTYPE_MASK)
	jr z, .jump_left
	cp (COLLISION_JUMP_SW & COLLISION_SUBTYPE_MASK)
	jr z, .jump_left
	cp (COLLISION_JUMP_NW & COLLISION_SUBTYPE_MASK)
	jr z, .jump_left
	jp CheckWalkLeft
.jump_left
	ld a, JUMP_LEFT
	ret

.right
	ld a, [wPlayerStandingTile]
	and COLLISION_SUBTYPE_MASK
	cp (COLLISION_JUMP_E & COLLISION_SUBTYPE_MASK)
	jr z, .jump_right
	cp (COLLISION_JUMP_SE & COLLISION_SUBTYPE_MASK)
	jr z, .jump_right
	cp (COLLISION_JUMP_NE & COLLISION_SUBTYPE_MASK)
	jr z, .jump_right
	jp CheckWalkRight
.jump_right
	ld a, JUMP_RIGHT
	ret

CheckWalkDown:: ; 03:4502
	ld d, 0
	ld e, 1
	call CheckObjectCollision
	jr c, .face_down
	ld a, [wTileDown]
	call CheckCollisionSolid
	jr c, .face_down
	ld a, STEP_DOWN
	ret
.face_down
	ld a, FACE_DOWN
	ret

CheckWalkUp:: ; 03:4519
	ld d, 0
	ld e, -1
	call CheckObjectCollision
	jr c, .face_up
	ld a, [wTileUp]
	call CheckCollisionSolid
	jr c, .face_up
	ld a, STEP_UP
	ret
.face_up
	ld a, FACE_UP
	ret

CheckWalkLeft:: ; 03:4530
	ld d, -1
	ld e, 0
	call CheckObjectCollision
	jr c, .face_left
	ld a, [wTileLeft]
	call CheckCollisionSolid
	jr c, .face_left
	ld a, STEP_LEFT
	ret
.face_left
	ld a, FACE_LEFT
	ret

CheckWalkRight:: ; 03:4547
	ld d, 1
	ld e, 0
	call CheckObjectCollision
	jr c, .face_right
	ld a, [wTileRight]
	call CheckCollisionSolid
	jr c, .face_right
	ld a, STEP_RIGHT
	ret
.face_right
	ld a, FACE_RIGHT
	ret

CheckMovementSurf:: ; 03:455e
	ld a, [wPlayerStandingTile]
	swap a
	and  LOW((COLLISION_TYPE_MASK >> 4) | (COLLISION_TYPE_MASK << 4))
	ld hl, .SurfCollisionTable
	jp CallJumptable

.SurfCollisionTable ; 03:456b
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfWater
	dw CheckMovementSurfWater2
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular

CheckMovementSurfRegular:: ; 03:458b
	ldh a, [hJoyState]
	bit D_DOWN_F, a
	jp nz, CheckSurfDown
	bit D_UP_F, a
	jp nz, CheckSurfUp
	bit D_LEFT_F, a
	jp nz, CheckSurfLeft
	bit D_RIGHT_F, a
	jp nz, CheckSurfRight
	jp NoWalkMovement

CheckMovementSurfWater:: ; 03:45a4
	ld a, [wPlayerStandingTile]
	and COLLISION_SUBTYPE_MASK
	cp (COLLISION_WATERFALL & COLLISION_SUBTYPE_MASK)
	jr nz, CheckMovementSurfRegular
; waterfall
	ld a, FAST_STEP_DOWN
	ret

CheckMovementSurfWater2:: ; 03:45b0
	ld a, [wPlayerStandingTile]
	and COLLISION_WATER_SUBTYPE_MASK
	ld d, STEP_RIGHT
	jr z, .finish ; COLLISION_WATER2_E
	ld d, STEP_LEFT
	cp (COLLISION_WATER2_W & COLLISION_WATER_SUBTYPE_MASK)
	jr z, .finish
	ld d, STEP_UP
	cp (COLLISION_WATER2_N & COLLISION_WATER_SUBTYPE_MASK)
	jr z, .finish
	ld d, STEP_DOWN
	cp (COLLISION_WATER2_S & COLLISION_WATER_SUBTYPE_MASK)
	jr z, .finish
	; fall-through --> no aliasing due to mask
.finish
	ld a, d
	ret

CheckSurfDown: ; 03:45cd
	ld d, 0
	ld e, 1
	call CheckObjectCollision
	jr c, .face_down
	ld a, [wTileDown]
	call CheckCollisionSometimesSolid
	jr c, .face_down ; FIXME: This assumes cut-trees are solid, which they aren't.
	                ;        You can walk into them from water because of this.
	call nz, SurfDismount
	ld a, STEP_DOWN
	ret
.face_down
	ld a, FACE_DOWN
	ret

CheckSurfUp: ; 03:45e7
	ld d, 0
	ld e, -1
	call CheckObjectCollision
	jr c, .face_up
	ld a, [wTileUp]
	call CheckCollisionSometimesSolid
	jr c, .face_up ; FIXME: This assumes cut-trees are solid, which they aren't.
	              ;        You can walk into them from water because of this.
	call nz, SurfDismount
	ld a, STEP_UP
	ret
.face_up
	ld a, FACE_UP
	ret

CheckSurfLeft: ; 03:4601
	ld d, -1
	ld e, 0
	call CheckObjectCollision
	jr c, .face_left
	ld a, [wTileLeft]
	call CheckCollisionSometimesSolid
	jr c, .face_left ; FIXME: This assumes cut-trees are solid, which they aren't.
	                ;        You can walk into them from water because of this.
	call nz, SurfDismount
	ld a, STEP_LEFT
	ret
.face_left
	ld a, FACE_LEFT
	ret

CheckSurfRight: ; 03:461b
	ld d, 1
	ld e, 0
	call CheckObjectCollision
	jr c, .face_right
	ld a, [wTileRight]
	call CheckCollisionSometimesSolid
	jr c, .face_right ; FIXME: This assumes cut-trees are solid, which they aren't.
	                 ;        You can walk into them from water because of this.
	call nz, SurfDismount
	ld a, STEP_RIGHT
	ret
.face_right
	ld a, FACE_RIGHT
	ret

SurfDismount: ; 03:4635
	jp SetPlayerStateWalk

CheckObjectCollision:: ; 03:4638
; Check if coordinates relative
; to player collide with another object
; Clobbers:
; a, hl
; Input:
; de - Relative coords x, y
; Output:
; nc - no collision
;  c - collision
; hObjectStructIndexBuffer - Event ID of colliding event
	ld a, PLAYER_OBJECT_INDEX
	ldh [hEventCollisionException], a
	ld a, [wPlayerNextMapX]
	add d
	ld d, a
	ld a, [wPlayerNextMapY]
	add e
	ld e, a
	callab _CheckObjectCollision
	ret nc
	jp CheckCompanionObjectCollision

CheckCollisionSolid::
; Checks whether collision ID in a
; is solid or not.
; Clobbers:
; hl
; Input:
;  a - collision ID
; Result:
;  a - collision type
;  c - solid
; nc - not solid
	call GetCollisionType
	and a
	ret z
	scf
	ret

GetCollisionType::
; Get collision type for collision ID in a
; Clobbers: hl
; Input:
;  a - collision ID
; Result:
;  a - collision type
;      00 - not solid
;      01 - sometimes solid (cut tree, water etc.)
;      0F - always solid
	push de
	ld hl, CollisionTypeTable
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	pop de
	ret

CollisionTypeTable: ; 03:4664
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $00
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     ALWAYS_SOLID    ; $04
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $08
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     ALWAYS_SOLID    ; $0C
	db NEVER_SOLID,     NEVER_SOLID,     SOMETIMES_SOLID, NEVER_SOLID     ; $10
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $14
	db NEVER_SOLID,     NEVER_SOLID,     SOMETIMES_SOLID, NEVER_SOLID     ; $18
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $1C
	db SOMETIMES_SOLID, SOMETIMES_SOLID, SOMETIMES_SOLID, SOMETIMES_SOLID ; $20
	db SOMETIMES_SOLID, SOMETIMES_SOLID, SOMETIMES_SOLID, ALWAYS_SOLID    ; $24
	db SOMETIMES_SOLID, SOMETIMES_SOLID, SOMETIMES_SOLID, SOMETIMES_SOLID ; $28
	db SOMETIMES_SOLID, SOMETIMES_SOLID, SOMETIMES_SOLID, ALWAYS_SOLID    ; $30
	db SOMETIMES_SOLID, SOMETIMES_SOLID, SOMETIMES_SOLID, SOMETIMES_SOLID ; $34
	db SOMETIMES_SOLID, SOMETIMES_SOLID, SOMETIMES_SOLID, SOMETIMES_SOLID ; $38
	db SOMETIMES_SOLID, SOMETIMES_SOLID, SOMETIMES_SOLID, SOMETIMES_SOLID ; $3C
	db SOMETIMES_SOLID, SOMETIMES_SOLID, SOMETIMES_SOLID, SOMETIMES_SOLID ; $40
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $44
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $48
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $4C
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $50
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $54
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $58
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $5C
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $60
	db NEVER_SOLID,     NEVER_SOLID,     ALWAYS_SOLID,    NEVER_SOLID     ; $64
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $68
	db NEVER_SOLID,     NEVER_SOLID,     ALWAYS_SOLID,    NEVER_SOLID     ; $6C
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $70
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $74
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $78
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $7C
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $80
	db ALWAYS_SOLID,    ALWAYS_SOLID,    ALWAYS_SOLID,    ALWAYS_SOLID    ; $84
	db ALWAYS_SOLID,    NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $88
	db ALWAYS_SOLID,    ALWAYS_SOLID,    ALWAYS_SOLID,    ALWAYS_SOLID    ; $8C
	db ALWAYS_SOLID,    NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $90
	db ALWAYS_SOLID,    ALWAYS_SOLID,    ALWAYS_SOLID,    ALWAYS_SOLID    ; $94
	db ALWAYS_SOLID,    ALWAYS_SOLID,    NEVER_SOLID,     ALWAYS_SOLID    ; $98
	db ALWAYS_SOLID,    ALWAYS_SOLID,    ALWAYS_SOLID,    ALWAYS_SOLID    ; $9C
	db ALWAYS_SOLID,    ALWAYS_SOLID,    NEVER_SOLID,     ALWAYS_SOLID    ; $A0
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $A4
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $A8
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $AC
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $B0
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $B4
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $B8
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $BC
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $C0
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $C4
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $C8
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $CC
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $D0
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $D4
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $D8
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $DC
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $E0
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $E4
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $E8
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $EC
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $F0
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $F4
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $F8
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID     ; $FC
	db NEVER_SOLID,     NEVER_SOLID,     NEVER_SOLID,     ALWAYS_SOLID    ; $100

_UnusedReturnFalse:: ; 03:4764
	xor a
	ret

_UnusedReturnTrue:: ; 03:4766
	xor a
	scf
	ret

CheckCollisionSometimesSolid:: ; 03:4769
; Checks whether collision ID in a
; is sometimes, always or never solid.
; Clobbers:
; hl
; Input:
;  a - collision ID
; Result:
;  c - always solid
; nc - sometimes not solid, check a
;  a - result
;      00 - sometimes solid
;      01 - never solid
	call GetCollisionType
	cp SOMETIMES_SOLID
	jr z, .sometimes_solid
	and a
	jr z, .never_solid
	jr .always_solid
.sometimes_solid
	xor a
	ret
.never_solid
	ld a, 1
	and a
	ret
.always_solid
	scf
	ret


SECTION "_RedrawPlayerSprite", ROMX[$4000], BANK[$05]

_RedrawPlayerSprite: ; 05:4000
	call GetPlayerSprite
	ld hl, vChars0
	call LoadOverworldSprite
	ret

GetPlayerSprite: ; 05:400a
	ld a, [wPlayerState]
	ld hl, PlayerSpriteTable
	ld c, a
.loop
	ld a, [hli]
	cp c
	jr z, .match
	inc hl
	cp -1
	jr nz, .loop
	xor a
	ld [wPlayerState], a
	ld a, SPRITE_GOLD
	jr .skip
.match
	ld a, [hl]
.skip
	ld [wUsedSprites], a
	ld [wPlayerSprite], a
	ld [wPlayerObjectSprite], a
	ret
	
PlayerSpriteTable: ; 03:402d
; state, sprite
	db PLAYER_NORMAL, SPRITE_GOLD
	db PLAYER_BIKE,   SPRITE_GOLD_BIKE
	db PLAYER_SKATE,  SPRITE_GOLD_SKATEBOARD
	db PLAYER_SURF,   SPRITE_LAPLACE
	db -1
