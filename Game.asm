.model small
.stack
.data
    ; Game Start X 
    startPosition   = 4
	
    ;Flag position
    flagPosition    = 315
	
    ; Mario Coordinates
    marioStart_X    = 10
	marioStart_Y    = 158
    marioHeight    = 18
	marioWidth     = 14
	
    ; Enemy1 Coordinate
    enemyStart_Y    = 158
    enemyHeight    = 18
	enemyWidth     = 18

    ; kingdom positions
	kingdomTop_X       = 290
	kingdomTop_Y       = 128
	kingdomBottom_X    = 286
	kingdomBottom_Y    = 148

    ; Jumps variable
    jumpHeight      WORD    0
    jumpFall    	WORD    0
    jumpPower      	WORD    ?
    jumpPowerHalf   WORD    ?
    jumpTime        BYTE    ?

    ; Constant Coordinate for the hurdles
   	hurdle1_X    = 45
	hurdle1_Y    = 152
	hurdle2_X    = 155
	hurdle2_Y    = 146
	hurdle3_X    = 240
	hurdle3_Y    = 157

    ; hurdle lengths
    hurdleTopLength     = 26
	hurdleBottomLength  = 22

    ; Flag Coordinate
    flag_X       = 315
    Flag_Y       = 120

    ; kingdomfixed Coordinates
    kingdomTopHeight    = 24
	kingdomTopWidth     = 25
	kingdomBottomHeight = 28
	kingdomBottomWidth  = 32
	
    ; Monster fixed Coordinates
	monsterHeight  = 35
	monsterWidth   = 34
	monsterStart_X  = 10
	monster_Y       = 13
	monsterLeftMax      = 40
	monsterRightMax     = 265

    ; Bomb fixed values
    bombStart_Y    = 29
	bombHeight     = 9
	bombWidth      = 8

    ; Arrow Keys Constants
    arrowLeftKey        = 4Bh
	arrowRightKey       = 4Dh
	arrowUpKey          = 48h

    ; This Macro set the cursor on that row and column
    setCursor macro row, col
	push ax
	push bx
	push dx
        mov dh, row
        mov dl, col
        mov ah, 02h
        mov bh, 0
        int 10h
	pop dx
	pop bx
	pop ax
	endm
	
    ; This Macro writes a character to the screen
    writeCharacter macro char
	push ax
	push bx
	push cx
        mov al, char
        mov ah, 0Ah
        mov bh, 0
        mov bl, 15
        mov cx, 1
        int 10h
	pop cx
	pop bx
	pop ax
	endm

    ; Basic Shapes of the Oject Arrays 

    ; For Drawing the hurdle
    hurdleTop       BYTE 2, 2, 2, 6, 2, 2, 2, 6, 2, 2, 2, 6, 2, 2, 2,6, 2, 2, 2, 6, 2, 2, 2, 6, 2, 2,2
	hurdleBottom    BYTE 2, 2, 2, 15, 2, 2, 15, 2, 2, 15, 2, 2, 15, 2, 2, 15, 2, 2, 15, 2, 2, 2 
    
    ; colors for the Mario
    mario  			BYTE 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54
                    BYTE 54, 54, 54, 54, 40, 40, 40, 40, 40, 54, 54, 54, 54, 54
                    BYTE 54, 54, 54, 40, 40, 40, 40, 40, 40, 40, 40, 40, 54, 54
                    BYTE 54, 54, 54, 22, 22, 22, 42, 42, 22, 42, 54, 54, 54, 54
                    BYTE 54, 54, 22, 42, 22, 42, 42, 42, 22, 42, 42, 42, 54, 54
                    BYTE 54, 54, 22, 42, 22, 22, 42, 42, 42, 22, 42, 42, 42, 54
                    BYTE 54, 54, 22, 22, 42, 42, 42, 42, 22, 22, 22, 22, 54, 54
                    BYTE 54, 54, 54, 54, 42, 42, 42, 42, 42, 42, 42, 54, 54, 54
                    BYTE 54, 54, 54, 22, 22, 40, 22, 22, 40, 54, 54, 54, 54, 54
                    BYTE 54, 54, 22, 22, 22, 40, 22, 22, 40, 22, 22, 22, 54, 54
                    BYTE 54, 22, 22, 22, 22, 40, 40, 40, 40, 22, 22, 22, 22, 54
                    BYTE 54, 42, 42, 22, 40, 42, 40, 40, 42, 40, 22, 42, 42, 54
                    BYTE 54, 42, 42, 42, 40, 40, 40, 40, 40, 40, 42, 42, 42, 54
                    BYTE 54, 42, 42, 40, 40, 40, 40, 40, 40, 40, 40, 42, 42, 54
                    BYTE 54, 54, 54, 40, 40, 40, 54, 54, 40, 40, 40, 54, 54, 54
                    BYTE 54, 54, 22, 22, 22, 54, 54, 54, 54, 22, 22, 22, 54, 54
                    BYTE 54, 22, 22, 22, 22, 54, 54, 54, 54, 22, 22, 22, 22, 54
                    BYTE 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54
    
    ; Color 2-D Array for the Enemy
    enemy           BYTE 54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54
                    BYTE 54,54,54,54,54,54,54, 6, 6, 6, 6,54,54,54,54,54,54,54
                    BYTE 54,54,54,54,54,54, 6, 6, 6, 6, 6, 6,54,54,54,54,54,54
                    BYTE 54,54,54,54,54, 6, 6, 6, 6, 6, 6, 6, 6,54,54,54,54,54
                    BYTE 54,54,54,54, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,54,54,54,54
                    BYTE 54,54,54, 6, 0, 0, 6, 6, 6, 6, 6, 6, 0, 0, 6,54,54,54
                    BYTE 54,54, 6, 6, 6,85, 0, 6, 6, 6, 6, 0,85, 6, 6, 6,54,54
                    BYTE 54,54, 6, 6, 6,85, 0, 0, 0, 0, 0, 0,85, 6, 6, 6,54,54
                    BYTE 54, 6, 6, 6, 6,85, 0,85, 6, 6,85, 0,85, 6, 6, 6, 6,54
                    BYTE 54, 6, 6, 6, 6,85,85,85, 6, 6,85,85,85, 6, 6, 6, 6,54
                    BYTE 54, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,54
                    BYTE 54,54, 6, 6, 6, 6,85,85,85,85,85,85, 6, 6, 6, 6,54,54
                    BYTE 54,54,54,54,54,85,85,85,85,85,85,85,85,54,54,54,54,54
                    BYTE 54,54,54, 0, 0,85,85,85,85,85,85,85,85,54,54,54,54,54
                    BYTE 54,54, 0, 0, 0, 0, 0,85,85,85,85,85, 0, 0,54,54,54,54
                    BYTE 54,54, 0, 0, 0, 0, 0, 0,85,85,85, 0, 0, 0,54,54,54,54
                    BYTE 54,54,54, 0, 0, 0, 0, 0,85,85, 0, 0, 0,54,54,54,54,54
                    BYTE 54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54

    ; Colors 2-D Array for the KingdomTop				
	kingdomTop      BYTE    54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54
                    BYTE    54,54,54,54,54,41,54,54,54,54,54,54,54,54,54,54,54,54,54,41,54,54,54,54,54
                    BYTE    54,54,54,54,41,41,41,54,54,54,54,54,54,54,54,54,54,54,41,41,41,54,54,54,54
                    BYTE    54,54,54,41,41,41,41,41,54,54,54,54,54,54,54,54,54,41,41,41,41,41,54,54,54
                    BYTE    54,54,41,41,41,41,41,41,41,54,54,54,54,54,54,54,41,41,41,41,41,41,41,54,54
                    BYTE    54,41,41,41,41,41,41,41,41,41,54,54,54,54,54,41,41,41,41,41,41,41,41,41,54
                    BYTE    41,41,41,41,41,41,41,41,41,41,41,54,54,54,41,41,41,41,41,41,41,41,41,41,41
                    BYTE    41,41,41,41,41,41,41,41,41,41,41,54,54,54,41,41,41,41,41,41,41,41,41,41,41
                    BYTE    41,41,41,41,41,41,41,41,41,41,41,54,54,54,41,41,41,41,41,41,41,41,41,41,41
                    BYTE    41,41,41,41,41,41,41,41,41,41,41,54,54,54,41,41,41,41,41,41,41,41,41,41,41
                    BYTE    41,41,41,41,41,41,41,41,41,41,41,54,54,54,41,41,41,41,41,41,41,41,41,41,41
                    BYTE    41,41,41,41,14,14,14,41,41,41,41,54,54,54,41,41,41,41,14,14,14,41,41,41,41
                    BYTE    41,41,41,41,14,14,14,41,41,41,41,54,54,54,41,41,41,41,14,14,14,41,41,41,41
                    BYTE    41,41,41,41,14,14,14,41,41,41,41,54,54,54,41,41,41,41,14,14,14,41,41,41,41
                    BYTE    41,41,41,41,14,14,14,41,41,41,41,54,54,54,41,41,41,41,14,14,14,41,41,41,41
                    BYTE    41,41,41,41,14,14,14,41,41,41,41,54,54,54,41,41,41,41,14,14,14,41,41,41,41
                    BYTE    41,41,41,41,14,14,14,41,41,41,41,54,54,54,41,41,41,41,14,14,14,41,41,41,41
                    BYTE    41,41,41,41,14,14,14,41,41,41,41,54,54,54,41,41,41,41,14,14,14,41,41,41,41
                    BYTE    41,41,41,41,14,14,14,41,41,41,41,54,54,54,41,41,41,41,14,14,14,41,41,41,41
                    BYTE    41,41,41,41,14,14,14,41,41,41,41,54,54,54,41,41,41,41,14,14,14,41,41,41,41
                    BYTE    41,41,41,41,41,41,41,41,41,41,41,54,54,54,41,41,41,41,41,41,41,41,41,41,41
                    BYTE    41,41,41,41,41,41,41,41,41,41,41,54,54,54,41,41,41,41,41,41,41,41,41,41,41
                    BYTE    41,41,41,41,41,41,41,41,41,41,41,54,54,54,41,41,41,41,41,41,41,41,41,41,41
                    BYTE    41,41,41,41,41,41,41,41,41,41,41,54,54,54,41,41,41,41,41,41,41,41,41,41,41

    ; Color 2-D Array for the Kingdom bottom
    kingdomBottom   BYTE     8, 8, 8, 8, 8, 0, 8, 8, 8, 8, 8, 8, 8, 0, 8, 8, 8, 8, 8, 8, 8, 0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8
                    BYTE     8, 8, 8, 8, 8, 0, 8, 8, 8, 8, 8, 8, 8, 0, 8, 8, 8, 8, 8, 8, 8, 0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8
                    BYTE     8, 8, 8, 8, 0, 0, 8, 8, 8, 8, 8, 0, 0, 0, 8, 8, 8, 8, 8, 0, 0, 0, 8, 8, 8, 8, 8, 0, 8, 8, 8, 8
                    BYTE     0, 0, 8, 8, 8, 8, 8, 0, 0, 0, 8, 8, 8, 8, 8, 0, 0, 0, 8, 8, 8, 8, 8, 0, 0, 0, 8, 8, 8, 8, 8, 0
                    BYTE     8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0
                    BYTE     8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0
                    BYTE     8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0
                    BYTE     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                    BYTE     8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 0, 0, 0, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8
                    BYTE     8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 0, 0, 0, 0, 0, 0, 0, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8
                    BYTE     8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 0, 0, 0, 0, 0, 0, 0, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8
                    BYTE     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                    BYTE     8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0
                    BYTE     8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0
                    BYTE     8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0
                    BYTE     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                    BYTE     8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8
                    BYTE     8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8
                    BYTE     8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8
                    BYTE     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                    BYTE     8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0
                    BYTE     8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0
                    BYTE     8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0
                    BYTE     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                    BYTE     8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8
                    BYTE     8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8
                    BYTE     8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8
                    BYTE     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

    ; Monster color 2-D Array
	monster     	BYTE    54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54
					BYTE    54,54,54,54,54,54,54,54,54,54,54,54,54,85,85,85,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54
					BYTE    54,54,54,54,54,54,54,54,54, 2, 2,85,85,85,14,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54
					BYTE    54,54,54,54,54,54,54,54, 2, 2, 2,85,85,14,14,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54
					BYTE    54,54,54,54,54,54,85,85, 2, 2, 2, 2,14,14, 2,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54
					BYTE    54,54,14,54,54, 2,85,85, 2, 2, 2, 2, 2, 2, 2,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54
					BYTE    54,14,54,14, 2, 2,85,85, 2, 2, 2, 2, 2, 2, 2,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54
					BYTE    54,14,14,14,85,85,85, 2, 2, 2,14, 2, 2, 2, 2, 2,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54
					BYTE    54,14,14,14,14,85, 2, 2, 2,14,14,14, 2, 2, 2, 2,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54
					BYTE    54,85,14,14,14, 2, 2,14,14,85, 2,14, 2, 2, 2, 2,85,85, 2, 2, 2,85,54,54,54,54,54,54,54,54,54,54,54,54
					BYTE    54,54,85,54,14,14,14,14, 2, 2, 2,14, 2, 2, 2, 2,85,85, 2, 2,85,85,14, 2,54,54,54,54,54,54,54,54,54,54
					BYTE    54,54,85,54,85,85, 2,85, 2, 2,85,14, 2, 2, 2, 2,85,85, 2,85,85,85,14,14, 2,85,85,85,54,54,54,54,54,54
					BYTE    54,54,54,54,54,85,54,54,54, 2,14,14, 2, 2, 2,85,85,85, 2, 2,85,14,14, 2, 2,85,85,14,54,54,54,54,54,54
					BYTE    54,54,54,54,54,54,54,54,54,85,14,14, 2, 2,85,85,85, 2, 2, 2, 2, 2, 2, 2, 2, 2,14,14, 2,85,54,54,54,54
					BYTE    54,54,54,54,54,54,54,54,54,14,14, 2, 2,85,85,85, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,85,54,54,54,54
					BYTE    54,54,54,54,54,54,54,85,14,14,14, 2, 2,85,85,85, 2, 2, 2, 2, 2, 2,85,85,85, 2, 2, 2, 2, 2,54,54,54,54
					BYTE    54,54,54,54,54,54,54,54,14,14,54,54, 2, 2,85,85,85,85,85,85, 2, 2,85,85,14, 2, 2, 2,85,85,85,54,54,54
					BYTE    54,54,54,54,54,54,54,54,54,54,54,54,54,54, 2, 2,14,14,14,85,85, 2, 2,14,14, 2, 2, 2,85,85,14,54,54,54
					BYTE    54,54,54,54,54,54,54,54,54,54,14,14,14,54,54,85,54,14,14,14,85,85, 2, 2, 2, 2, 2, 2, 2,14,14,54,54,54
					BYTE    54,54,54,54,54,54,54,54,54,14,14,85,54,14,14,14,54,85,14,14, 2,85, 2, 2, 2, 2, 2, 2, 2, 2, 2,85,54,54
					BYTE    54,54,54,54,54,54,54,54,54,14,14,54,54,14,14,14,14,54,54, 2, 2,85, 2, 2, 2,85,85,85, 2, 2, 2,14,85,54
					BYTE    54,54,54,54,54,54,54,54,54,14,85,54,14,14,14,14,14,14,85, 2, 2,85,85, 2, 2,85,85,14, 2, 2, 2,54,54,54
					BYTE    54,54,54,54,54,54,54,54,54,14,54,54,14,14,14,14,14, 2, 2, 2, 2,85,85, 2, 2, 2,14,14, 2, 2,85,85,54,54                  
					BYTE    54,54,54,54,54,54,54,54,54,54,85,54,14,14,14,14,14, 2, 2, 2, 2,85,85, 2, 2, 2, 2, 2, 2, 2,85,85,85,54
					BYTE    54,54,54,54,54,54,54,54,54,54,54,54,85,14,14,14,54, 2, 2, 2, 2, 2,85, 2, 2, 2, 2,85,85, 2,14,14,54,54
					BYTE    54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54, 2, 2, 2, 2, 2,85,85, 2, 2, 2,14, 2, 2,14, 2,54,54
					BYTE    54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54, 2, 2, 2, 2, 2, 2,85,85, 2, 2, 2, 2, 2, 2, 2,54,54
					BYTE    54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54, 2, 2, 2, 2, 2, 2,85,85,85, 2, 2, 2, 2, 2,54,54
					BYTE    54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54, 2, 2, 2, 2, 2, 2,85,85,85,85, 2, 2, 2,54,54
					BYTE    54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,14, 2, 2, 2, 2, 2, 2, 2,85,85,85,85,85,85,54
					BYTE    54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,85,85,14,14, 2, 2,14,14,14,14,14,85,85,85,85,54
					BYTE    54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,85,85,85,14,14,14,14,14,14,14,14,14,14,14,85,54,54
					BYTE    54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,85,85,14,14,85,85,14,14,14,14,14,54,54,54
					BYTE    54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,85,85,85,14,85,85,85,14,14,14,14,14,14,54,54
					BYTE    54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54

    ; Bomb 2-D Array for Drawing               
	bomb          	BYTE    54,54,54,54,54,54,54,54
                    BYTE    54,54,54,15,15,15,54,54
                    BYTE    54,54,15,15,15,15,15,54
                    BYTE    54,15,15,15,15,15,15,15
                    BYTE    54,15,15,15,15,15,15,15
                    BYTE    54,15,15,15,15,15,15,15
                    BYTE    54,54,15,15,15,15,15,54
                    BYTE    54,54,54,15,15,15,54,54
                    BYTE    54,54,54,54,54,54,54,54				

    ; This structure is used to specify position of all the Object in 2D Screen
    screenPosition struct
        x   WORD    ?
        y   WORD    ?
    screenPosition ends
    
    ; Coordinate of Objects
    marioPosition       screenPosition <>
    monsterPosition     screenPosition <>
    enemyPosition       screenPosition 2 DUP(<>)
    bombPosition  	    screenPosition 2 DUP(<>)
    hurdles           	screenPosition 3 DUP(<>)

    ; Coordinate for Enemy
	enemyDirection      BYTE    2 DUP(0)
    enemyStatus    		BYTE    2 DUP(0)
	monsterDirection    BYTE    0	
	bombTime1    	    BYTE    20, 55
    bombTime2          	BYTE    20, 55

    ; Welcome Strings
    welcomeString1  BYTE    "Super Mario Game!"
    welcomeString2  BYTE    "Enter Username"
    welcomeString3  BYTE    "Press Enter To Play"
    scoreString     BYTE    "Score: "
    livesString     BYTE    "Lives: "
    levelString     BYTE    "Level: "
    winString       BYTE    "You Won!"
    loseString      BYTE    "You Lost!"

    ; Varying Values
    score           WORD    0
    level           WORD    1
    lives           WORD    3
	
.code
;-----------------------------------------
; This Is the Main Program, that will handle functioning 
; of all the game. This function calls Respective level 
; When the respecive level condition is meet.
;-----------------------------------------
main proc
mov ax, @data
mov ds, ax
    mov ah, 0
    mov al, 13h                            
    int 10h
    call WelComeScreen
    call resetHurdlesPosition
    call drawFixedObjects

    ; Level1 Checks
    Level_1:
        call firstLevel
        call flagCollision
        cmp ah, 1
        je transitionLevel2
        sub lives, 1
        cmp lives, 0
        je end_game
    jmp Level_1

    ; level2 check
    transitionLevel2:
	    mov level,2
	    call drawFixedObjects
	    add score,10
    Level_2:
        call secondLevel
        call flagCollision
        cmp ah, 1
        je transitionLevel3
        sub lives, 1
        cmp lives, 0
        je end_game
    jmp Level_2
	
    ; Level3 check
	transitionLevel3:
	mov level,3
	call drawFixedObjects
	add score,10
	Level_3:
		call thirdLevel
		call flagCollision
		cmp ah, 1
		je end_game
		sub lives, 1
		cmp lives, 0
		jne Level_3

; End Screen of the Game		
end_game:
	add score,10
    call drawEndScreen
; Exit the Game
exit:
    mov ah, 4Ch
    int 21h
main endp
;-----------------------------------------
; This Section Contain Procedure for Drawing and All 
; the logic of the Game. The main function call the 
; the respective level. Also, All the statics object 
; have been drawn before the call to respective level. 
;-----------------------------------------

;-----------------------------------------
; This function handle the logic for displaying
; the Welcome Screen and Taking name as Input. 
; This function also Display Strings at start.
; Don't let User to Enter Game Till he press Enter
;-----------------------------------------
WelComeScreen proc uses ax bx cx
    ; Display of String1
    mov bx, offset welcomeString1
    mov ah, 8
    mov al, 10
    mov cx, lengthof welcomeString1
    call displayString
    ; Display of String2
    mov bx, offset welcomeString2
    mov ah, 10
    mov al, 10
    mov cx, lengthof welcomeString2
    call displayString
    ; Display of String3
    mov bx, offset welcomeString3
    mov ah, 14
    mov al, 10
    mov cx, lengthof welcomeString3
    call displayString
    ; Taking Input and check for Enter
    mov bl, 10
    EnterCheck:
        mov ah, 01
        int 16h
        jz EnterCheck
        push ax
            setCursor 12, bl
            mov ah,01h
            int 21h
        pop ax
        cmp ah, 0Eh
        jne EnterCh
        dec bl
        setCursor 12, bl
        mov dl,' '
        mov ah,02h
        int 21h
        jmp EnterCheck
        EnterCh:
        inc bl
        cmp ah, 1Ch
        jne EnterCheck
ReturnMain:
    ret
WelComeScreen endp

;-----------------------------------------
; This function Reset Position of the Hurdles after Each level
; Since the Postion struct have Memory of word.We have assigned 
; Position of each hurdle According to it.
;-----------------------------------------
resetHurdlesPosition proc
    mov Hurdles[0].x, hurdle1_X
    mov Hurdles[0].y, hurdle1_Y
    mov Hurdles[4].x, hurdle2_X
    mov Hurdles[4].y, hurdle2_Y
    mov Hurdles[8].x, hurdle3_X
    mov Hurdles[8].y, hurdle3_Y
    ret
resetHurdlesPosition endp

;-----------------------------------------
; This function draws all  Fixed objects on  
; the screen such as the  hurdles  and  the 
; flags, Ground, Sky, and Interface of Game  
;-----------------------------------------
drawFixedObjects proc uses cx dx
    call drawSky
    call drawGround
	cmp level,3
	je Next
    call drawFlag
	Next:
    mov ax, 19
    mov cx, hurdles[0].y
    mov dx, hurdles[0].x
    call drawHurdle
    mov ax, 25
    mov cx, hurdles[4].y
    mov dx, hurdles[4].x
    call drawHurdle
    mov ax, 14
    mov cx, hurdles[8].y
    mov dx, hurdles[8].x
    call drawHurdle

    ret
drawFixedObjects endp
;-----------------------------------------
; Takes length of the Hurdle Array in AX
; Takes the  Drawing row index in CX
; Takes the  Drawing col index in DX
; This function draws a Hurdle at the given 
; row & col index.
;-----------------------------------------
drawHurdle proc uses ax bx cx dx si
    push ax
    mov bx, offset hurdleTop
    mov ax, dx
    mov dx, cx
    mov cx, 10
    HurdleTOpLoop:
        push cx
        mov cx, lengthof hurdleTop
        call drawArray1D
        inc dx

        pop cx
    loop HurdleTOpLoop

    mov bx, offset hurdleBottom
    add ax, 2
    pop cx
    bottom_loop:
        push cx

        mov cx, lengthof hurdleBottom
        call drawArray1D
        inc dx

        pop cx
        loop bottom_loop
    ret
drawHurdle endp
;-----------------------------------------
; Takes the offset of color array in BX 
; Takes the Size of the color array in CX
; Takes the Row  index in DX
; Takes the start of Coloumn index in AX 
; This Draw a 1D Array of Colors onto the Screen. 
;-----------------------------------------
drawArray1D proc uses ax bx cx dx si
    mov si, 0
    draw_loop:
        push cx
        mov cx, ax
        mov al, [bx + si]
        mov ah, 0Ch
        int 10h
        inc si
        inc cx
        mov ax, cx
        pop cx
        loop draw_loop
    ret
drawArray1D endp

;-----------------------------------------
; Takes Colors Array offset  in BX.
; Takes the starting row index in CX
; Takes the starting col index in DX
; Takes the rows & columns in STACK 
; Display a 2D Array of colors on the Screen
;-----------------------------------------
drawArray2D proc uses ax bx cx dx si
    mov bp, sp
    mov ax, dx
    mov dx, cx
    mov cx, [bp + 14]
    draw2DArrayloop:
        push cx

        mov cx, [bp + 12]
        call drawArray1D
        inc dx
        add bx, cx     
        pop cx
        loop draw2DArrayloop
    ret 4
drawArray2D endp

;-----------------------------------------
; This function draws the sky blue background 
; of the game,making it appear like a sky.
;-----------------------------------------
drawSky proc uses ax bx cx dx
    mov ah, 06h
    mov al, 0
    mov cx, 0
    mov dh, 25
    mov dl, 40
    mov bh, 54
    int 10h
    ret
drawSky endp
;-----------------------------------------
; This function draws the brown Color background 
; of the game,making it appear like a sky.
;-----------------------------------------
drawGround proc uses ax bx cx dx
    mov ah,06               
    mov al,0                
    mov ch,byte ptr 22      
    mov cl,byte ptr 0       
    mov bh,6                
    mov dh,25               
    mov dl,100              
    int 10h                 
    ret
drawGround endp

;-----------------------------------------
; This function draws the flag at a Given location
;-----------------------------------------
drawFlag proc
    call drawFlagBanner
    call drawFlagPole
    ret
drawFlag endp

;-----------------------------------------
; This function draws the banner of the flag 
; according to the Given X,Y location
;-----------------------------------------
drawFlagBanner proc uses ax bx cx dx
	mov ah, 06h
    mov al, 0
    mov ch, 7
	mov cl, 34
    mov dh, 9
    mov dl, 38
    mov bh, 1
    int 10h
    ret
drawFlagBanner endp
;-----------------------------------------
; This function draws the pole of the flag
; according to the Given X,Y  location
;-----------------------------------------
drawFlagPole proc uses ax cx dx
    mov dx, 56
    mov cx, Flag_Y
        PoleDrawLoop:
            push cx
            mov cx, flag_X
            mov al, 15
            mov ah, 0Ch
            int 10h
            inc dx
            pop cx
        loop PoleDrawLoop
    ret
drawFlagPole endp

;-----------------------------------------
; This  function take row and col index in AH:AL
; Takes the String offset in the BX Register.
; Takes length of the String in the cx Register
; Draws the String at the Given Row and Column
;-----------------------------------------
displayString proc uses ax bx cx dx si
    mov si, 0
    DrawLoop:
        setCursor ah, al
        writeCharacter [bx + si]
        add al, 1
        add si, 1
        loop DrawLoop
    ret
displayString endp

;-----------------------------------------
; Level Implementation Logic Starts Here
;-----------------------------------------

;-----------------------------------------
; This procedure Runs for First level.
; Implements Drawing and movement of Mario.
;-----------------------------------------
firstLevel proc uses ax cx dx
    call SetMarioPosition

    mov jumpPower, 1200
    mov jumpPowerHalf, 600
    mov jumpTime, 10

    Level1Loop:
		mov bx, offset livesString
		mov ah, 0
		mov al, 0
		mov cx, lengthof livesString
		call displayString
		add al, 6
		mov dx, lives
		call displayNumber
		
		mov bx, offset scoreString
		mov ah, 0
		mov al, 15
		mov cx, lengthof scoreString
		call displayString
		add al, 6
		mov dx, score
		call displayNumber
		
		mov bx, offset levelString
		mov ah, 0
		mov al, 33
		mov cx, lengthof levelString
		call displayString
		add al, 6
		mov dx, level
		call displayNumber
		
        call drawMario
        call moveMario
        cmp ah, 1
        je ReturnMain
        jmp Level1Loop
ReturnMain:
    ret
firstLevel endp

;-----------------------------------------
; This function  implements all the required functionality 
; for level2. Which include drawing of Objectand proper 
; movement of enemy and their collisions with mario.
;-----------------------------------------
secondLevel proc uses ax bx cx dx
    call clearMovingObjects
    call SetMarioPosition
    call resetEnemies

    mov jumpPower, 480
    mov jumpPowerHalf, 240
    mov jumpTime, 4

    mov cx, 0
    mov bl, 10
    Level2Loop:
		push cx
		push bx
		mov bx, offset livesString
		mov ah, 0
		mov al, 0
		mov cx, lengthof livesString
		call displayString
		add al, 6
		mov dx, lives
		call displayNumber
		
		mov bx, offset scoreString
		mov ah, 0
		mov al, 15
		mov cx, lengthof scoreString
		call displayString
		add al, 6
		mov dx, score
		call displayNumber
		
		mov bx, offset levelString
		mov ah, 0
		mov al, 33
		mov cx, lengthof levelString
		call displayString
		add al, 6
		mov dx, level
		call displayNumber
		pop bx
		pop cx
		
        inc cx
        call drawEnemy
        call drawMario

        mov ax, cx
        div bl
        cmp ah, 0
        jne MovementContinue

        call moveEnemy
        mov cx, 0
        cmp ah, 1
        je ReturntoMain
    MovementContinue:
        call moveMario
        cmp ah, 1
        je ReturntoMain
        jmp Level2Loop
ReturntoMain:
    ret
secondLevel endp

;-----------------------------------------
; This function implements all the required functionality 
; for level3. Which include  drawing & proper movement
; of the monster, Bombs and all other  collisions.
;-----------------------------------------
thirdLevel proc uses ax bx cx dx
    call clearMovingObjects
    call SetMarioPosition
    call resetEnemies
    call resetMonster
    call drawKingdom

    mov jumpPower, 240
    mov jumpPowerHalf, 120
    mov jumpTime, 2

    mov bombPosition[0].x, 40
    mov bombPosition[0].y, bombStart_Y
    mov bombPosition[4].x, 80
    mov bombPosition[4].y, bombStart_Y

    mov cx, 0
    mov bl, 4
    level3loop:
		push cx
		push bx
		mov bx, offset livesString
		mov ah, 0
		mov al, 0
		mov cx, lengthof livesString
		call displayString
		add al, 6
		mov dx, lives
		call displayNumber
		
		mov bx, offset scoreString
		mov ah, 0
		mov al, 15
		mov cx, lengthof scoreString
		call displayString
		add al, 6
		mov dx, score
		call displayNumber
		
		mov bx, offset levelString
		mov ah, 0
		mov al, 33
		mov cx, lengthof levelString
		call displayString
		add al, 6
		mov dx, level
		call displayNumber
		pop bx
		pop cx
	
        inc cx
        call drawEnemy
        call drawMario
        call drawAllBombs
        call drawMonster

        mov ax, cx
        div bl
        cmp ah, 0
        jne MovementContinue

        call moveMonster
        call moveBombs
        cmp ah, 1
        je ReturnMain

        call moveEnemy
        cmp ah, 1
        je ReturnMain
        mov cx, 0
        MovementContinue:
        call moveMario
        cmp ah, 1
        je ReturnMain
        jmp level3loop
ReturnMain:
    ret
thirdLevel endp



;-----------------------------------------
; Logic for Drawing all the Moving Objects Start Here
;-----------------------------------------

;-----------------------------------------
; This function draws mario at the location specified
; Used DrawArray2D  function to draw the mario.
;-----------------------------------------
drawMario proc uses bx cx dx
    mov bx, offset mario
    mov cx, marioHeight
    push cx
    mov cx, marioWidth
    push cx
    mov cx, marioPosition.y
    mov dx, marioPosition.x
    call drawArray2D
    ret
drawMario endp

;-----------------------------------------
; This function uses a loop to draw both the enemy sprites
; on the screen according to their screenPosition variables
; and it uses the function drawArray2D
;-----------------------------------------
drawEnemy proc uses ax bx cx dx
    mov cx, 2
    mov si, 0
    mov ax, 0
    draw_loop:
        push cx

        mov bx, ax
        cmp enemyStatus[bx], 1
        jne MovementContinue

        mov cx, enemyHeight
        push cx
        mov cx, enemyWidth
        push cx
        mov cx, enemyPosition[si].y
        mov dx, enemyPosition[si].x
        mov bx, offset enemy
        call drawArray2D

    MovementContinue:
        add si, 4
        add ax, 1
        pop cx
        loop draw_loop
    ret
drawEnemy endp
;-----------------------------------------
; This function draws the monster at the
; location specified by its screenPosition 
; variable using the function drawArray2D
;-----------------------------------------
drawMonster proc uses bx cx dx
    mov bx, offset monster
    mov cx, monsterHeight
    push cx
    mov cx, monsterWidth
    push cx
    mov cx, monsterPosition.y
    mov dx, monsterPosition.x
    call drawArray2D
    ret
drawMonster endp

;-----------------------------------------
; This function draws the bombs on the screen according
; to the positions stored in the bombPosition array.
;-----------------------------------------
drawAllBombs proc uses cx dx
    cmp bombTime2[0], 0
    jne SecondBomb
    ; First bomb
    mov cx, bombPosition[0].y
    mov dx, bombPosition[0].x
    call drawBomb

SecondBomb:
    cmp bombTime2[1], 0
    jne ReturnMain
    mov cx, bombPosition[4].y
    mov dx, bombPosition[4].x
    call drawBomb

ReturnMain:
    ret
drawAllBombs endp

;-----------------------------------------
; Takes the Drawing row index in CX
; Takes the Drawing col index in DX
; This function draws a bomb at the 
; given row & col index (Indices from top Left)
;-----------------------------------------
drawBomb proc uses bx cx dx
    mov bx, bombHeight
    push bx
    mov bx, bombWidth
    push bx
    mov bx, offset bomb
    call drawArray2D
    ret
drawBomb endp

;-----------------------------------------
; This function draws Kingdom at the location
; specified Using DrawArray2D  function.
;-----------------------------------------
drawKingdom proc uses bx cx dx
    mov bx, offset kingdomTop
    mov cx, kingdomTopHeight
    push cx
    mov cx, kingdomTopWidth
    push cx
    mov cx, kingdomTop_Y
    mov dx, kingdomTop_X
    call drawArray2D

    mov bx, offset kingdomBottom
    mov cx, kingdomBottomHeight
    push cx
    mov cx, kingdomBottomWidth
    push cx
    mov cx, kingdomBottom_Y
    mov dx, kingdomBottom_X
    call drawArray2D
    ret
drawKingdom endp


;-----------------------------------------
; Logic for Reseting the Moving Object Coordinates Start Here
;-----------------------------------------

;-----------------------------------------
; This function sets the X & Y position (screenPosition) of
; the mario according to the constants defined at the top. 
;-----------------------------------------
SetMarioPosition proc
    mov marioPosition.x, marioStart_X
    mov marioPosition.y, marioStart_Y
    ret
SetMarioPosition endp

;-----------------------------------------
;This function sets the X & Y position (screenPosition) of
; the Enemies according to the constants defined at the top. 
;-----------------------------------------
resetEnemies proc
    mov enemyPosition[0].x, hurdle1_X
    add enemyPosition[0].x, hurdleTopLength
    inc enemyPosition[0].x
    mov enemyPosition[0].y, enemyStart_Y
    mov enemyPosition[4].x, hurdle2_X
    add enemyPosition[4].x, hurdleTopLength
    inc enemyPosition[4].x
    mov enemyPosition[4].y, enemyStart_Y

    mov enemyStatus[0], 1
    mov enemyStatus[1], 1
    ret
resetEnemies endp

;-----------------------------------------
; This function sets the X & Y position (screenPosition) of
; the Monster according to the constants defined at the top. 
;-----------------------------------------
resetMonster proc
    mov monsterPosition.x, monsterStart_X
    mov monsterPosition.y, monster_Y
    ret
resetMonster endp

;-----------------------------------------
; Takes the screenPosition array  index  in  SI
; This resets the bomb to match position of the monster
;-----------------------------------------
resetBomb proc uses ax bx cx si
    mov bombPosition[si].y, bombStart_Y
    mov cx, monsterPosition.x
    add cx, monsterWidth / 2
    mov bombPosition[si].x, cx
    ret
resetBomb endp



;-----------------------------------------
; Logic for clearing the Moving Object Coordinates Start Here
;-----------------------------------------

;-----------------------------------------
; This function clear the screen before
; the start of any Level. 
;-----------------------------------------
clearMovingObjects proc uses ax bx cx dx
    call clearMario
    call clearEnemies
    cmp level, 3
    jne ReturnMain
    call clearMonster
    call clearAllBombs
ReturnMain:
    ret
clearMovingObjects endp

;-----------------------------------------
; This function clears the mario from the screen
; and draw its position with the background 
; color using the resetScreen function
;-----------------------------------------
clearMario proc uses ax bx cx dx
    mov ax, marioHeight
    mov bx, marioWidth
    mov cx, marioPosition.y
    mov dx, marioPosition.x
    sub dx, 1
    call resetScreen
    mov jumpHeight, 0
    mov jumpFall, 0
    ret
clearMario endp

;-----------------------------------------
; This function clears the enemies from the screen
; and draw at their positions with the background 
; color using the resetScreen function
;-----------------------------------------
clearEnemies proc uses ax bx cx dx si
    mov ax, enemyHeight
    mov bx, enemyWidth
    mov cx, 3
    mov si, 0
    EnemyClearLoop:
        push cx
        mov cx, enemyPosition[si].y
        mov dx, enemyPosition[si].x
        call resetScreen
        add si, 4
        pop cx
        loop EnemyClearLoop
    ret
clearEnemies endp

;-----------------------------------------
; This function clears the monster from the screen
; and draw its positions with the background color
; using the resetScreen function
;-----------------------------------------
clearMonster proc uses ax bx cx dx
    mov ax, monsterHeight
    mov bx, monsterWidth
    mov cx, monsterPosition.y
    mov dx, monsterPosition.x
    sub dx, 1
    call resetScreen
    ret
clearMonster endp

;-----------------------------------------
; This function clears the Bombs from the screen
; and redraw their positions with the background 
; color using the resetScreen function
;-----------------------------------------
clearAllBombs proc uses bx cx si
    mov cx, 2
    mov si, 0
    mov bx, 0
    BombClearloop:
        call clearBomb
        add bx, 1
        add si, 4
        loop BombClearloop
    ret
clearAllBombs endp

;-----------------------------------------
; Takes the bombPosition array's index in SI
; Takes the bombTime2 array's index in BX
; This function clears the specified bomb from the screen 
; by drawing the area with the background color
;-----------------------------------------
clearBomb proc uses ax bx cx dx
	push ax
	mov al, bombTime1[bx]
	mov bombTime2[bx], al
	pop ax
    mov ax, bombHeight
    mov bx, bombWidth
    mov cx, bombPosition[si].y
    mov dx, bombPosition[si].x
    call resetScreen
    ret
clearBomb endp



;-----------------------------------------
; This segment Contains logic for Mario,Enemy,Monster Movement.
;-----------------------------------------

;-----------------------------------------
; ReturnMains bool in AH(1: FLAG_REACHED, 0:NOT_REACHED )
; This function actually moves the mario, check for 
; hurdle and flag reaching condition. 
;-----------------------------------------
moveMario proc
    mov ah, 01
    int 16h
    jz Jump
    mov ah, 0
    int 16h

    cmp ah, arrowRightKey
    je MoveRight
    cmp ah, arrowLeftKey
    je MoveLeft
    cmp ah, arrowUpKey
    je JumpReady
    jmp Jump

MoveRight:
    call marioRightMovement
    cmp ah, 1
    je ReturnMain
    jmp Jump
MoveLeft:
    call marioLeftMovement
    jmp Jump
JumpReady:
    cmp jumpHeight, 0
    jne Jump
	push ax
	mov ax, jumpPower
	mov jumpHeight, ax
	pop ax
    jmp Jump

Jump:
    mov ah, 0
    call marioJumpMovement
ReturnMain:
    ret
moveMario endp

;-----------------------------------------
; ReturnMains bool in AH (1: FLAG REACHED ,0: NOT REACHED)
; This function handles the Right movement of the mario.
; It also checks if mario has collided with any handles
;-----------------------------------------
marioRightMovement proc uses cx dx
    mov ah, 0
    add marioPosition.x, 1
    mov cx, marioPosition.y
    add cx, marioHeight - 1
    mov dx, marioPosition.x
    add dx, marioWidth - 1
    call hurdleCollision
    cmp ah, 1
    jne flag_check
    mov ah, 0
    sub marioPosition.x, 1
    jmp ReturnMain
flag_check:
    call flagCollision
ReturnMain:
    ret
marioRightMovement endp
;-----------------------------------------
; This function handles the left movement of the mario.
; It also checks if mario has collided with any handles.
;-----------------------------------------
marioLeftMovement proc uses ax cx dx
    sub marioPosition.x, 1
    mov cx, marioPosition.y
    add cx, marioHeight - 1
    mov dx, marioPosition.x
    call hurdleCollision
    cmp ah, 1
    jne Notcollide
    add marioPosition.x, 1
    jmp ReturnMain
    Notcollide:
    sub cx, marioHeight - 1
StartCheck:
    cmp marioPosition.x, startPosition
    ja ReturnMain
    add marioPosition.x, 1
ReturnMain:
    ret
marioLeftMovement endp


;-----------------------------------------
; This function handles all the logic of making the
; mario character jump and fall down to Ground. 
;-----------------------------------------
marioJumpMovement proc uses ax bx
    cmp jumpHeight, 0
    jne JumpStart
    cmp jumpFall, 0
    je ReturnMain
    jmp JumpFallDown

JumpStart:
    mov ax, jumpHeight
    mov bl, jumpTime
    div bl
    cmp ah, 0
    jne jumpdec

    mov ax, jumpPowerHalf
    cmp jumpHeight, ax
    ja upjump
    jmp downjump

upjump:
    sub marioPosition.y, 1
    jmp jumpdec
downjump:
    add marioPosition.y, 1
    call marioFeetCollision
    cmp ah, 1
    jne jumpdec
    sub marioPosition.y, 1
    mov bx, jumpHeight
    add jumpFall, bx
    mov jumpHeight, 1
    jmp jumpdec

JumpFallDown:
    add marioPosition.y, 1
    call marioFeetCollision
    sub marioPosition.y, 1
    cmp ah, 1
    je ReturnMain
    mov bx, jumpFall
    mov jumpHeight, bx
    mov jumpFall, 0
    jmp downjump

jumpdec:
    dec jumpHeight
ReturnMain:
    ret
marioJumpMovement endp

;-----------------------------------------
; ReturnMains a bool in AH (0: NO_COLLISION_WITH_MARIO, 1: COLLISION)
; This function handles the movement of the enemies
; between two hurdles as well as its collision with the mario.
;-----------------------------------------
moveEnemy proc uses bx cx dx si
    mov ah, 0
    mov cx, 2
    mov si, 0
    mov bx, 0
    EnemyMoveLoop:
        push cx
        cmp enemyStatus[bx], 1
        jne MovementContinue
        cmp enemyDirection[bx], 0
        je right_move
        jmp left_move

        right_move:
        call enemyRightMovement
        cmp ah, 1
        je handle_collision
        jmp MovementContinue

        left_move:
        call enemyLeftMovement
        cmp ah, 1
        je handle_collision

        MovementContinue:
        add si, 4
        add bx, 1
        pop cx
    loop EnemyMoveLoop
jmp ReturnMain
handle_collision:
    pop cx
ReturnMain:
    ret
moveEnemy endp

;-----------------------------------------
; Takes the enemyPosition array's index in SI.
; Takes the enemyStatus array's index in BX.
; Returns bool in AH (0: NO_COLLISION, 1: COLLISION)
; This function moves the enemy to the right if needed.
; It also checks if the enemy has collided with the MARIO.
;-----------------------------------------
enemyRightMovement proc uses bx cx dx si
    add enemyPosition[si].x, 1
    mov cx, enemyPosition[si].y
    add cx, enemyHeight - 1
    mov dx, enemyPosition[si].x
    add dx, enemyWidth - 1
    call hurdleCollision
    cmp ah, 1
    jne HitMario
    sub enemyPosition[si].x, 1
    mov enemyDirection[bx], 1

HitMario:
    call marioEnemyCollision
ReturnMain:
    ret
enemyRightMovement endp

;-----------------------------------------
; Takes the enemyPosition array's index in SI
; Takes the enemyStatus array's index in BX
; Returns bool in AH (0: NO COLLISION, 1: COLLISION)
; This function moves the enemy to the left if needed.
; It also checks if the enemy has collided with the MARIO.
;-----------------------------------------
enemyLeftMovement proc uses bx cx dx si
    sub enemyPosition[si].x, 1
    mov cx, enemyPosition[si].y
    add cx, enemyHeight - 1
    mov dx, enemyPosition[si].x
    call hurdleCollision

    cmp ah, 1
    jne marioHit
    add enemyPosition[si].x, 1
    mov enemyDirection[bx], 0

marioHit:
    call marioEnemyCollision
ReturnMain:
    ret
enemyLeftMovement endp

;-----------------------------------------
; This function handles the movement of the monster
; between the two X-Axis Limits fixed on top.
;-----------------------------------------
moveMonster proc
    cmp monsterDirection, 0
    je MoveRight
    jmp MoveLeft

MoveRight:
    add monsterPosition.x, 1
    cmp monsterPosition.x, monsterRightMax
    jb ReturnMain
    mov monsterDirection, 1

MoveLeft:
    sub monsterPosition.x, 1
    cmp monsterPosition.x, monsterLeftMax
    ja ReturnMain
    mov monsterDirection, 0
ReturnMain:
    ret
moveMonster endp

;-----------------------------------------
; Return a bool in AH (0: NO_COLLISION, 1: COLLISION)
; This is the main function which utilizes a loop to
; handle the movement of each of the Bomb and its 
; collision With the Mario.
;-----------------------------------------
moveBombs proc uses bx cx dx si
    mov cx, 2
    mov bx, 0
    mov si, 0
    BombMoveLoop:
        push cx
        cmp bombTime2[bx], 0
        jne decSpeed

        call bombInteractions
        cmp ah, 1
        je pop_stack
        jmp  MovementContinue
    decSpeed:
        sub bombTime2[bx], 1
        cmp bombTime2[bx], 0
        jne MovementContinue
        call resetBomb 
    MovementContinue:
        add bx, 1
        add si, 4
        pop cx
        loop BombMoveLoop

mov ah, 0
jmp Return
pop_stack:
    pop cx
Return:
    ret
moveBombs endp


;-----------------------------------------
; Logic for the collisions Detection with different Object Start Here 
;-----------------------------------------

;-----------------------------------------
; Takes the point row index in CX
; Takes the point col index in DX
; Returns bool in AH (0: NO COLLISION, 1: COLLISION) 
; This function checks if the given point (CX:DX)
; is colliding with the mario.
;-----------------------------------------
marioCollision proc uses bx cx dx
    mov ah, 0
    mov bx, marioPosition.x
    cmp dx, bx
    jb Returns
    add bx, marioWidth - 1
    cmp dx, bx
    ja Returns
    
    mov bx, marioPosition.y
    cmp cx, bx
    jb Returns
    add bx, marioHeight - 1
    cmp cx, bx
    ja Returns
    mov ah, 1
Returns:
    ret
marioCollision endp


;-------------------------------------
; Check For the mario collision During Jump
; ReturnMains bool in AH (0: NO_COLLISION, 1: COLLISION)
; This function checks if mario's feet are colliding with any pipe
;-------------------------------------
marioFeetCollision proc uses cx dx
    mov cx, marioPosition.y
    add cx, marioHeight - 1
    mov dx, marioPosition.x
    call hurdleCollision
    cmp ah, 1
    je Returns
    
    add dx, marioWidth - 1
    call hurdleCollision
Returns:
    ret
marioFeetCollision endp


;-----------------------------------------
; Returns bool in AH (0: NO, 1: YES)
; This function checks if Mario has reached the Flag
; Used for changing the level of the Game
;-----------------------------------------
flagCollision proc uses cx
    mov ah, 0
    mov cx, marioPosition.x
    add cx, marioWidth - 1
    cmp level, 3
    je level_3_check

    cmp cx, flagPosition
    jb Returns
    mov ah, 1
    jmp Returns
level_3_check:
    cmp cx, kingdomBottom_X
    jb Returns
    mov ah, 1
Returns:
    ret
flagCollision endp


;-----------------------------------------
; Takes the Object row index in CX
; Takes the Object col index in DX
; ReturnMains bool in AH (0: NO COLLISION, 1: COLLISION) 
; This function checks if the given Object (CX:DX)
; is colliding with any pipe
;-----------------------------------------
hurdleCollision proc uses bx cx dx si
    mov bp, sp
    mov ah, 0
    mov si, 0
    mov cx, 3
    collisionDetectionLoop:
        push cx
        mov bx, hurdles[si].x

        cmp dx, bx
        jb StackClear
        add bx, hurdleTopLength - 1
        cmp dx, bx
        ja CheckNextIteration

        mov cx, [bp + 4]
        cmp cx, hurdles[si].y
        jb CheckNextIteration
        mov ah, 1
        jmp StackClear

    CheckNextIteration:
        add si, 4
        pop cx
        loop collisionDetectionLoop

jmp Returns
StackClear:
    pop cx
Returns:
    ret
hurdleCollision endp

;-----------------------------------------
; Takes the enemyPosition array's index in SI
; Takes the enemyStatus array's index in BX
; Returns a bool in AH (0: NO COLLISION, 1: COLLISION)
; This function checks if any enemy colliding with mario 
;-----------------------------------------
marioEnemyCollision proc uses cx dx
    mov cx, enemyPosition[si].y
    mov dx, enemyPosition[si].x
    add dx, enemyWidth / 2
    call marioCollision
    cmp ah, 1
    je Returns

    sub dx, (enemyWidth / 2) - 1
    add cx, enemyHeight / 5
    call marioCollision
    cmp ah, 1
    je Returns

    add dx, enemyWidth - 3
    call marioCollision
    cmp ah, 1
    je Returns

    add cx, enemyHeight / 4
    call marioCollision
    cmp ah, 1
    je Returns

    sub dx, enemyWidth - 3
    call marioCollision
Returns:
    ret
marioEnemyCollision endp


;-----------------------------------------
; Takes the bombPosition array's index in SI
; Takes the bombTime2 array's index in BX
; Returns a bool in AH (0: NO_ COLLISION, 1: COLLISION)
; This function determine the collision of the 
; Bomb with hurdles, mario etc
;-----------------------------------------
bombInteractions proc uses cx
    add bombPosition[si].y, 1
    mov cx, bombPosition[si].y
    add cx, bombHeight
    cmp cx, 176
    jae Bombclear1

hurdleCheck:
    call bombHurdleInteraction
    cmp ah, 1
    je Bombclear1
mario_check:
    call bombMarioInteraction
    jmp Returns

Bombclear1:
    mov ah, 0
    call clearBomb
Returns:
    ret
bombInteractions endp

;-----------------------------------------
; Takes the bombPosition array's index in SI
; Takes the bombTime2 array's index in BX
; Returns a bool in AH (0: NO_COLLISION_WITH_HURDLES, 1: COLLISION)
; This function determines the collision of hurdle with bomb
;-----------------------------------------
bombHurdleInteraction proc uses cx dx
    mov cx, bombPosition[si].y
    add cx, bombHeight
    mov dx, bombPosition[si].x
    call hurdleCollision
    cmp ah, 1
    je ReturnMain

    add dx, bombWidth - 1
    call hurdleCollision
ReturnMain:
    ret
bombHurdleInteraction endp


;-----------------------------------------
; Takes the bombPosition array's index in SI
; Takes the bombTime2 array's index in BX
; Returns a bool in AH (0: NO_COLLISION_WITH_MARIO, 1: COLLISION)
; This function determines the collision of the bomb with mario
;-----------------------------------------
bombMarioInteraction proc uses cx dx
    mov cx, bombPosition[si].y
    add cx, bombHeight - 2
    mov dx, bombPosition[si].x
    call marioCollision
    cmp ah, 1
    je Returns

    add dx, bombWidth - 1
    call marioCollision
Returns:
    ret
bombMarioInteraction endp


;-----------------------------------------
; Section Dealing with End screen Logic 
;-----------------------------------------

;-----------------------------------------
; Takes the start of painting row index in CX
; Takes the start of painting column index in DX
; Takes the painting size in AX:BX (AX: Num. of Rows, BX: Num. of Cols)
; Fills the specified area with the color of the background
; resets the specified square
;-----------------------------------------
resetScreen proc uses ax bx cx dx
    mov bp, sp
    mov cx, ax
    mov al, 54
    mov ah, 0Ch
    resetScreenloop1:
        push cx
            
        mov cx, bx
        mov dx, [bp]
        resetScreenloop2:
            push cx

            mov cx, dx
            mov dx, [bp + 2]
            int 10h
            mov dx, cx
            inc dx

            pop cx
            loop resetScreenloop2

        mov cx, [bp + 2]
        inc cx
        mov [bp + 2], cx

        pop cx
        loop resetScreenloop1
    ret
resetScreen endp

;-----------------------------------------
; This function clear the whole screen
; and erases anything currently drawn.
;-----------------------------------------
eraseScreen proc uses ax bx cx dx
    mov ah, 06h
    mov al, 0
    mov cx, 0
    mov dh, 25
    mov dl, 40
    mov bh, 0
    int 10h
    ret
eraseScreen endp


;-----------------------------------------
; Takes a boolean in AH denoting if the player 
; won or lost. (0: LOST, 1: WON)
; This functions clear the whole screen
; and then draws out the required strings that
; make up the endgame screen.
;-----------------------------------------
drawEndScreen proc uses ax bx cx dx
    call eraseScreen
    cmp ah, 1
    je won_game

    mov bx, offset loseString
    mov ah, 10
    mov al, 15
    mov cx, 9
    call displayString
    jmp MovementContinue

won_game:
    mov bx, offset winString
    mov ah, 10
    mov al, 15
    mov cx, 8
    call displayString

MovementContinue:
    call displayScoreLevel
    ret
drawEndScreen endp

;-----------------------------------------
;This function draws the score as well as the
;level achieved by player in the game when it ends.
;-----------------------------------------
displayScoreLevel proc uses ax bx cx dx
    mov bx, offset scoreString
    mov ah, 12
    mov al, 15
    mov cx, 7
    call displayString

    add al, 7
    mov dx, score
    call displayNumber
    
    mov bx, offset levelString
    mov ah, 14
    mov al, 15
    mov cx, 7
    call displayString

    add al, 7
    mov dx, level
    call displayNumber
    setCursor 25, 0
    ret
displayScoreLevel endp

;-----------------------------------------
; Takes the row:col index in AH:AL
; Takes the number in DX
; This function draws a multidigit number 
; at the given row and col indices
;-----------------------------------------
displayNumber proc uses ax bx cx dx
    mov bp, sp
    mov cx, 0
    mov bl, 10
    stackloop:
        mov ax, dx
        div bl

        mov dh, 0
        mov dl, al
        mov al, ah
        mov ah, 0
        push ax
        inc cx

        cmp dx, 0
        je printnumber
        jmp stackloop

printnumber:
    mov ax, [bp + 6]
    printloop:
        setCursor ah, al
        pop dx
        add dl, 48
        writeCharacter dl
        add al, 1
        loop printloop
    ret
displayNumber endp

end main