; This file for the FamiStudio Sound Engine and was generated by FamiStudio

.if FAMISTUDIO_CFG_C_BINDINGS
.export _music_data_untitled=music_data_untitled
.endif

music_data_untitled:
	.byte 1
	.word @instruments
	.word @samples-148
	.word @song0ch0,@song0ch1,@song0ch2,@song0ch3,@song0ch4 ; 00 : Song 1
	.byte .lobyte(@tempo_env_1_mid), .hibyte(@tempo_env_1_mid), 0, 0

.export music_data_untitled
.global FAMISTUDIO_DPCM_PTR

@instruments:
	.word @env1,@env5,@env8,@env0 ; 00 : Arpeggios
	.word @env4,@env5,@env6,@env0 ; 01 : Bass
	.word @env3,@env5,@env7,@env9 ; 02 : Lead
	.word @env2,@env5,@env6,@env0 ; 03 : Noise Instrument

@samples:
	.byte $00+.lobyte(FAMISTUDIO_DPCM_PTR),$a9,$0f,$40	;37 (meow)

@env0:
	.byte $00,$c0,$7f,$00,$02
@env1:
	.byte $06,$ca,$ce,$cc,$00,$03,$c9,$c7,$c6,$c5,$c4,$00,$0a
@env2:
	.byte $00,$cf,$ca,$c6,$c5,$00,$04
@env3:
	.byte $00,$c9,$cc,$cf,$ce,$cd,$cc,$cb,$ca,$00,$08
@env4:
	.byte $00,$cf,$7f,$00,$02
@env5:
	.byte $c0,$7f,$00,$01
@env6:
	.byte $7f,$00,$00
@env7:
	.byte $c2,$7f,$00,$00
@env8:
	.byte $c1,$7f,$00,$00
@env9:
	.byte $00,$c0,$c2,$c3,$c2,$c0,$be,$bd,$be,$00,$08

@tempo_env_1_mid:
	.byte $03,$05,$80

@song0ch0:
@song0ch0loop:
	.byte $46, .lobyte(@tempo_env_1_mid), .hibyte(@tempo_env_1_mid), $75, $84, $08, $ff, $ff, $8b, $06, $ab, $04, $a9, $47, $06
	.byte $ff, $ff, $8b, $09, $ab, $08, $a9, $47, $04, $d7, $06, $ab, $08, $a9, $08, $d7, $04, $d7, $47, $01, $ff, $ff, $e5, $42
	.word @song0ch0loop
@song0ch1:
@song0ch1loop:
	.byte $73, $80
@song0ref46:
	.byte $1c, $95, $20, $93, $25, $93, $28, $93, $1c, $95, $20, $93, $25, $93, $28, $93
	.byte $41, $10
	.word @song0ref46
@song0ref65:
	.byte $1b, $95, $1e, $93, $24, $93, $27, $93, $1b, $95, $1e, $93, $24, $93, $27, $93
	.byte $41, $10
	.word @song0ref65
	.byte $41, $10
	.word @song0ref46
	.byte $41, $10
	.word @song0ref46
	.byte $0d, $95, $10, $93, $14, $93, $19, $93, $10, $95, $14, $93, $19, $93, $1c, $93, $14, $95, $19, $93, $1c, $93, $20, $93
	.byte $19, $95, $1c, $93, $20, $93, $25, $93, $42
	.word @song0ch1loop
@song0ch2:
@song0ch2loop:
	.byte $78, $82, $1c, $ff, $ff, $e5, $1b, $ff, $ff, $e5, $19, $ff, $ff, $e5, $20, $ff, $ff, $e5, $42
	.word @song0ch2loop
@song0ch3:
@song0ch3loop:
	.byte $72, $86
@song0ref150:
	.byte $29, $8b, $00, $87, $2c, $87, $2c, $89, $2c, $89, $28, $87, $2c, $87, $2f, $89, $29, $8b, $00, $87, $2c, $87, $2c, $89
	.byte $2c, $89, $25, $87, $2c, $87, $2f, $89
	.byte $41, $20
	.word @song0ref150
	.byte $41, $20
	.word @song0ref150
	.byte $41, $20
	.word @song0ref150
	.byte $41, $20
	.word @song0ref150
	.byte $41, $20
	.word @song0ref150
	.byte $41, $20
	.word @song0ref150
	.byte $41, $20
	.word @song0ref150
	.byte $42
	.word @song0ch3loop
@song0ch4:
@song0ch4loop:
	.byte $d9, $25, $d7, $00, $ff, $b1, $ff, $ff, $e7, $d9, $25, $d7, $00, $ff, $b1, $ff, $ff, $e7, $42
	.word @song0ch4loop
