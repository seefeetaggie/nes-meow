.segment "CODE"
FAMISTUDIO_CFG_EXTERNAL       = 1
FAMISTUDIO_CFG_DPCM_SUPPORT   = 1
FAMISTUDIO_CFG_SFX_SUPPORT    = 1 
FAMISTUDIO_CFG_SFX_STREAMS    = 2
FAMISTUDIO_CFG_EQUALIZER      = 1
FAMISTUDIO_USE_VOLUME_TRACK   = 1
FAMISTUDIO_USE_PITCH_TRACK    = 1
FAMISTUDIO_USE_SLIDE_NOTES    = 1
FAMISTUDIO_USE_VIBRATO        = 1
FAMISTUDIO_USE_ARPEGGIO       = 1
FAMISTUDIO_CFG_SMOOTH_VIBRATO = 1
FAMISTUDIO_USE_RELEASE_NOTES  = 1
FAMISTUDIO_DPCM_OFF           = $e000
.define FAMISTUDIO_CA65_ZP_SEGMENT   ZEROPAGE
.define FAMISTUDIO_CA65_RAM_SEGMENT  BSS
.define FAMISTUDIO_CA65_CODE_SEGMENT CODE
.include "famistudio_ca65.s"
.include "Notes N Stuff.s"

butter = $6F


.segment "HEADER"
  ; .byte "NES", $1A      ; iNES header identifier
  .byte $4E, $45, $53, $1A
  .byte 2               ; 2x 16KB PRG code
  .byte 1               ; 1x  8KB CHR data
  .byte $01, $00        ; mapper 0, vertical mirroring

.segment "VECTORS"
  ;; When an NMI happens (once per frame if enabled) the label nmi:
  .addr nmi
  ;; When the processor first turns on or is reset, it will jump to the label reset:
  .addr reset
  ;; External interrupt IRQ (unused)
  .addr 0

; "nes" linker config requires a STARTUP section, even if it's empty
.segment "STARTUP"

; Main code segment for the program
.segment "CODE"

controller:
  lda #$0
  sta butter
  lda #$1
  sta $4016
  lda #$0
  sta $4016

  ldx #$0
Tag:
  lda $4016 ;1 -> Abutton
  lsr A
  rol butter
  inx
  cpx #8
  bne Tag

  rts

reset:
  sei		; disable IRQs
  cld		; disable decimal mode
  ldx #$40
  stx $4017	; disable APU frame IRQ
  ldx #$ff 	; Set up stack
  txs		;  .
  inx		; now X = 0
  stx $2000	; disable NMI
  stx $2001 	; disable rendering
  stx $4010 	; disable DMC IRQs

;; first wait for vblank to make sure PPU is ready
vblankwait1:
  bit $2002
  bpl vblankwait1

;; second wait for vblank, PPU is ready after this
vblankwait2:
  bit $2002
  bpl vblankwait2

main:
load_palettes:
    ; TO DO: Copy palette data
  lda $2002
  lda #$3F
  sta $2006
  lda #$00
  sta $2006

;     .byte $37,$00,$10,$3c
;    .byte $37,$01,$16,$0f

  lda #$22
  sta $2007
  lda #$00
  sta $2007
  lda #$10
  sta $2007
  lda #$0f
  sta $2007

  lda #$37
  sta $2007
  lda #$01
  sta $2007
  lda #$16
  sta $2007
  lda #$0f
  sta $2007

load_nametable:
  lda $2002
  lda #$20
  sta $2006
  lda #$00
  sta $2006

  ldy #$02
  ldx #%11000000
Meow:
  lda #$d6
  sta $2007
  lda #$ce
  sta $2007
  lda #$d8
  sta $2007
  lda #$e0
  sta $2007
  lda #$a9
  sta $2007
  dex
  bne Meow
  dey
  bne Meow


enable_rendering:
  lda #%10000000	; Enable NMI
  sta $2000
  lda #%00011110	; Enable Sprites
  sta $2001

  lda FAMISTUDIO_CFG_NTSC_SUPPORT
  ldx #<(music_data_untitled)
  ldy #>(music_data_untitled)
  jsr famistudio_init

  lda #0 ;song
  jsr famistudio_music_play

forever:
  jmp forever

nmi:
  jsr controller
; runs new colour
  inc $6b  ;inc counter

  ;change colour
  
  lda $6b
  cmp #$80
  lda $2002
  lda #$3F
  sta $2006
  lda #$00
  sta $2006

  lda $6b
  cmp #$80
  bcs taggie
android:
  lda #$37
  jmp turtle
taggie:
  lda #$22
turtle: 
  sta $2007

  lda butter
  and #%01000000
  beq IFBNOTPRESSEDTHEN


IFBPRESSEDTHEN:
  lda $2002
  lda $6b
  eor #$FF
  sta $2005
  sta $2005
jmp scroll

IFBNOTPRESSEDTHEN:
;scroll
  lda $2002
  lda $6b
  sta $2005
  sta $2005
scroll:

  jsr famistudio_update
  
  rti

.segment "CHARS"
    ; Include the CHR ROM that has the different tiles available.
    .incbin "ellie1.chr"
