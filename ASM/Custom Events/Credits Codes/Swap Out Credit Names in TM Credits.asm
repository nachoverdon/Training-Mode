#To be inserted at 801aadb4
.macro branchl reg, address
lis \reg, \address @h
ori \reg,\reg,\address @l
mtctr \reg
bctrl
.endm

.macro branch reg, address
lis \reg, \address @h
ori \reg,\reg,\address @l
mtctr \reg
bctr
.endm

.macro load reg, address
lis \reg, \address @h
ori \reg, \reg, \address @l
.endm

.macro loadf regf,reg,address
lis \reg, \address @h
ori \reg, \reg, \address @l
stw \reg,-0x4(sp)
lfs \regf,-0x4(sp)
.endm

.macro backup
stwu	r1,-0x100(r1)	# make space for 12 registers
stmw	r20,8(r1)	# push r20-r31 onto the stack
mflr r0
stw r0,0xFC(sp)
.endm

.macro restore
lwz r0,0xFC(sp)
mtlr r0
lmw	r20,8(r1)	# pop r20-r31 off the stack
addi	r1,r1,0x100	# release the space
.endm

.macro intToFloat reg,reg2
xoris    \reg,\reg,0x8000
lis    r18,0x4330
lfd    f16,-0x7470(rtoc)    # load magic number
stw    r18,0(r2)
stw    \reg,4(r2)
lfd    \reg2,0(r2)
fsubs    \reg2,\reg2,f16
.endm

.set ActionStateChange,0x800693ac
.set HSD_Randi,0x80380580
.set HSD_Randf,0x80380528
.set Wait,0x8008a348
.set Fall,0x800cc730

.set entity,31
.set player,31
.set playerdata,31

b	FunctionStart

Names:
blrl
.long 0x43686172
.long 0x6C6F7474
.long 0x65000000

.long 0x48756768
.long 0x204E0000
.long 0x00000000

.long 0x48415242
.long 0x00000000
.long 0x00000000

.long 0x43797275
.long 0x73205200
.long 0x00000000

.long 0x72617665
.long 0x63616B65
.long 0x00000000

.long 0x4A657265
.long 0x6D790000
.long 0x00000000

.long 0x446F6D69
.long 0x6E69636B
.long 0x20540000

.long 0x526F6265
.long 0x72742050
.long 0x00000000

.long 0x4A6F6E61
.long 0x7468616E
.long 0x20420000

.long 0x44616E69
.long 0x656C2046
.long 0x00000000

.long 0x4D617273
.long 0x68616C6C
.long 0x205A0000

.long 0x54686F6D
.long 0x61732042
.long 0x00000000

.long 0x52697368
.long 0x69000000
.long 0x00000000

.long 0x4B454C4C
.long 0x5A000000
.long 0x00000000

.long 0x5475726B
.long 0x65790000
.long 0x00000000

.long 0x4F757473
.long 0x69646500
.long 0x00000000

.long 0x4A657373
.long 0x65000000
.long 0x00000000

.long 0x42656E53
.long 0x57000000
.long 0x00000000

.long 0x53657463
.long 0x68692000
.long 0x00000000

.long 0x4A696D6D
.long 0x79204D00
.long 0x00000000

.long 0x4D696361
.long 0x68205300
.long 0x00000000

.long 0x41766900
.long 0x00000000
.long 0x00000000

.long 0x59756E67
.long 0x5A756E67
.long 0x61000000

.long 0x52616E64
.long 0x6C65204A
.long 0x00000000

.long 0x416E6472
.long 0x65617320
.long 0x48000000

.long 0x43616C73
.long 0x7A6F6E65
.long 0x00000000

.long 0x52696C65
.long 0x79204400
.long 0x00000000

.long 0x416E7468
.long 0x6F6E7920
.long 0x43000000

.long 0x4B657669
.long 0x6E205400
.long 0x00000000

.long 0x5A616E65
.long 0x20520000
.long 0x00000000

.long 0x47616765
.long 0x204B0000
.long 0x00000000

.long 0x41726900
.long 0x00000000
.long 0x00000000

.long 0x56697472
.long 0x616C0000
.long 0x00000000

.long 0x43462054
.long 0x72756500
.long 0x00000000

.long 0x79617264
.long 0x73616C65
.long 0x00000000

.long 0x4A616D65
.long 0x73204C00
.long 0x00000000

.long 0x5A616368
.long 0x204E0000
.long 0x00000000

.long 0x53697220
.long 0x4C656D6F
.long 0x6E000000

.long 0x4D617474
.long 0x20420000
.long 0x00000000

.long 0x4D617820
.long 0x53000000
.long 0x00000000

.long 0x5265616C
.long 0x44696E67
.long 0x6F732000

.long 0x57617369
.long 0x66205200
.long 0x00000000

.long 0x66656D62
.long 0x6F792075
.long 0x77750000

.long 0x5370656E
.long 0x63657220
.long 0x47000000

.long 0x42656E20
.long 0x41000000
.long 0x00000000

.long 0x57696C6C
.long 0x69616D20
.long 0x52000000

.long 0x4B4A4800
.long 0x00000000
.long 0x00000000

.long 0x52656576
.long 0x65000000
.long 0x00000000

.long 0x43687269
.long 0x73746961
.long 0x6E204100

.long 0x45737465
.long 0x62616E20
.long 0x48000000

.long 0x466F7272
.long 0x65737420
.long 0x47000000

.long 0x41696465
.long 0x6E204300
.long 0x00000000

.long 0x47726F6C
.long 0x65780000
.long 0x00000000

.long 0x4D616E75
.long 0x656C2050
.long 0x00000000

.long 0x4D657468
.long 0x6F727068
.long 0x616E0000

.long 0x626F6666
.long 0x74617267
.long 0x65740000

.long 0x4D61726B
.long 0x204D0000
.long 0x00000000

.long 0x52656563
.long 0x65204500
.long 0x00000000

.long 0x4B61204D
.long 0x696E6720
.long 0x41430000

.long 0x424F4E53
.long 0x41492042
.long 0x4F595300

.long 0x4A65616E
.long 0x20540000
.long 0x00000000

.long 0x4A6F6E00
.long 0x00000000
.long 0x00000000

.long 0x53747561
.long 0x7274204B
.long 0x00000000

.long 0x4D696B65
.long 0x20520000
.long 0x00000000

.long 0x4A616D65
.long 0x73000000
.long 0x00000000

.long 0x4D696C6C
.long 0x65722054
.long 0x00000000

.long 0x44617272
.long 0x656E204D
.long 0x00000000

.long 0x53686167
.long 0x67794A00
.long 0x00000000

.long 0x20000000
.long 0x00000000
.long 0x00000000

.long 0x42727961
.long 0x6E204B00
.long 0x00000000

.long 0x436F6C6C
.long 0x696E2042
.long 0x00000000

.long 0x4C756361
.long 0x73205300
.long 0x00000000

.long 0x6A657265
.long 0x6D696168
.long 0x204B0000

.long 0x57696C6C
.long 0x20410000
.long 0x00000000

.long 0x45616361
.long 0x62000000
.long 0x00000000

.long 0x4D616363
.long 0x72656120
.long 0x50000000

.long 0x4A757374
.long 0x696E2048
.long 0x00000000

.long 0x5A616368
.long 0x204A0000
.long 0x00000000

.long 0x4272616E
.long 0x64742057
.long 0x00000000

.long 0x47656E65
.long 0x204B0000
.long 0x00000000

.long 0x4A617963
.long 0x6F622041
.long 0x00000000

.long 0x4A6F7365
.long 0x70682052
.long 0x00000000

.long 0x626C616E
.long 0x6465657A
.long 0x79000000

.long 0x56696D00
.long 0x00000000
.long 0x00000000

.long 0x726F6F62
.long 0x2061646F
.long 0x6F620000

.long 0x53616D69
.long 0x20420000
.long 0x00000000

.long 0x426C616B
.long 0x65205000
.long 0x00000000

.long 0x43686172
.long 0x6C6F6E00
.long 0x00000000

.long 0x416C6472
.long 0x696E2052
.long 0x00000000

.long 0x4A616E65
.long 0x204C0000
.long 0x00000000

.long 0x4D617274
.long 0x696E2052
.long 0x00000000

.long 0x53746570
.long 0x68616E65
.long 0x20530000

.long 0x47726567
.long 0x20570000
.long 0x00000000

.long 0x44656C61
.long 0x6E6F2057
.long 0x00000000

.long 0x4B796C65
.long 0x20530000
.long 0x00000000

.long 0x4B204F42
.long 0x7269656E
.long 0x00000000

.long 0x416C6265
.long 0x7274205A
.long 0x00000000

.long 0x4C796B6F
.long 0x6E000000
.long 0x00000000

.long 0x42656E6A
.long 0x616D696E
.long 0x20450000

.long 0x44617665
.long 0x20530000
.long 0x00000000

.long 0x4A6F7264
.long 0x616E204A
.long 0x00000000

.long 0x47656172
.long 0x00000000
.long 0x00000000

.long 0x46726974
.long 0x7A000000
.long 0x00000000

.long 0x4A656666
.long 0x204A0000
.long 0x00000000

.long 0x44616C74
.long 0x6F6E2047
.long 0x00000000

.long 0x54726576
.long 0x6F722043
.long 0x00000000

.long 0x43686164
.long 0x20530000
.long 0x00000000

.long 0x42726974
.long 0x20420000
.long 0x00000000

.long 0x41757374
.long 0x696E2044
.long 0x00000000

.long 0x4D696361
.long 0x68205700
.long 0x00000000

.long 0x4A6F6E61
.long 0x74686F6E
.long 0x204D0000

.long 0x4A61736F
.long 0x6E205600
.long 0x00000000

.long 0x4D617276
.long 0x696E2053
.long 0x00000000

.long 0x476C656E
.long 0x6E205400
.long 0x00000000

.long 0x4A6F7264
.long 0x616E204D
.long 0x00000000

.long 0x426A2043
.long 0x00000000
.long 0x00000000

.long 0x4C756369
.long 0x6F000000
.long 0x00000000

.long 0x42656E6E
.long 0x6F204B00
.long 0x00000000

.long 0x4265726E
.long 0x616E646F
.long 0x20420000

.long 0x4B617665
.long 0x68204100
.long 0x00000000

.long 0x54686F6D
.long 0x61732052
.long 0x00000000

.long 0x41757374
.long 0x696E204C
.long 0x00000000

.long 0x4272656E
.long 0x6E616E20
.long 0x52000000

.long 0x416E7468
.long 0x6F6E7920
.long 0x47000000

.long 0x5279616E
.long 0x204D0000
.long 0x00000000

.long 0x546F6E79
.long 0x204B0000
.long 0x00000000

.long 0x5368616E
.long 0x65204B00
.long 0x00000000

.long 0x416E6472
.long 0x65772057
.long 0x00000000

.long 0x56696E63
.long 0x656E7420
.long 0x54000000

.long 0x416C6920
.long 0x53000000
.long 0x00000000

.long 0x4E617468
.long 0x616E2048
.long 0x00000000

.long 0x4D617869
.long 0x6D652043
.long 0x00000000

.long 0x52696C65
.long 0x79204200
.long 0x00000000

.long 0x6361676C
.long 0x696F7374
.long 0x726F3900

.long 0x4A6F6E61
.long 0x7468616E
.long 0x204D0000

.long 0x52616661
.long 0x204D0000
.long 0x00000000

.long 0x4C756375
.long 0x69757320
.long 0x4D000000

.long 0x4A756C69
.long 0x65204D00
.long 0x00000000

.long 0x53657267
.long 0x696F2044
.long 0x00000000

.long 0x416E6472
.long 0x65204D4C
.long 0x4F000000

.long 0x4A75616E
.long 0x20440000
.long 0x00000000

.long 0x416E6472
.long 0x65772059
.long 0x00000000

.long 0x46616261
.long 0x64616D00
.long 0x00000000

.long 0x546F6E79
.long 0x20520000
.long 0x00000000

.long 0x44616E69
.long 0x656C2043
.long 0x00000000

.long 0x44657265
.long 0x78204500
.long 0x00000000

.long 0x43687269
.long 0x73204300
.long 0x00000000

.long 0x53616D75
.long 0x656C2043
.long 0x44000000

.long 0x4D656C65
.long 0x65205374
.long 0x61747300

.long 0x47656F72
.long 0x67652047
.long 0x00000000

.long 0x4A6F6579
.long 0x20410000
.long 0x00000000

.long 0x53746570
.long 0x68616E20
.long 0x4D000000

.long 0x4A61736F
.long 0x6E205300
.long 0x00000000

.long 0x4B726973
.long 0x20530000
.long 0x00000000

.long 0x4D696B65
.long 0x79205200
.long 0x00000000

.long 0x4A616B65
.long 0x204D0000
.long 0x00000000

.long 0x4C69616D
.long 0x204D0000
.long 0x00000000

.long 0x00000000
.long 0x00000000
.long 0x00000000

.long 0x416E6479
.long 0x20430000
.long 0x00000000

.long 0x53756E73
.long 0x65740000
.long 0x00000000

.long 0x57696C6C
.long 0x204E0000
.long 0x00000000

.long 0x44796C61
.long 0x6E204D00
.long 0x00000000

.long 0x4D617474
.long 0x68657720
.long 0x4C000000

.long 0x4D617474
.long 0x68657720
.long 0x50000000

.long 0x41696465
.long 0x6E204600
.long 0x00000000

.long 0x4D696368
.long 0x61656C20
.long 0x4F000000

.long 0x44726577
.long 0x20440000
.long 0x00000000

.long 0x54796C65
.long 0x72204D00
.long 0x00000000

.long 0x6D617361
.long 0x66756D73
.long 0x61000000

.long 0x4E617468
.long 0x616E2053
.long 0x00000000

.long 0x5175656E
.long 0x74696E20
.long 0x46000000

.long 0x426F6262
.long 0x79205363
.long 0x61720000

.long 0x4F757465
.long 0x7248616C
.long 0x6F000000

.long 0x4D617820
.long 0x52000000
.long 0x00000000

.long 0x54727563
.long 0x6B4A6974
.long 0x73750000

.long 0x53657468
.long 0x204D0000
.long 0x00000000

.long 0x4A616D69
.long 0x65204300
.long 0x00000000

.long 0x45646469
.long 0x65204100
.long 0x00000000

.long 0x436F6479
.long 0x204E0000
.long 0x00000000

.long 0x4A6F656C
.long 0x00000000
.long 0x00000000

.long 0x4B616C76
.long 0x61720000
.long 0x00000000

.long 0x53706563
.long 0x20546861
.long 0x6E6B7300

.long 0x41636869
.long 0x6C6C6573
.long 0x00000000

.long 0x44616E20
.long 0x53616C76
.long 0x61746F00

.long 0x50756E6B
.long 0x6C696E65
.long 0x00000000

.long 0x4452474E
.long 0x00000000
.long 0x00000000

.long 0x676F6466
.long 0x65640000
.long 0x00000000

.long 0x446F6C70
.long 0x68696E20
.long 0x456D7500

.long 0x4765636B
.long 0x6F204F53
.long 0x00000000

.long 0x00000000
.long 0x00000000
.long 0x00000000




FinalMessage:
blrl
.long 0xE700201d
.long 0x202b2024
.long 0x2031202e
.long 0x20361a20
.long 0x3720321a
.long 0x2024202f
.long 0x202f1a20
.long 0x30203c1a
.long 0x20332024
.long 0x20372035
.long 0x20322031
.long 0x20360320
.long 0x3a202b20
.long 0x321a2036
.long 0x20382033
.long 0x20332032
.long 0x20352037
.long 0x20282027
.long 0x1a203720
.long 0x2b202c20
.long 0x361a2033
.long 0x20352032
.long 0x202d2028
.long 0x20262037
.long 0x20ec0303
.long 0x03203a20
.long 0x3a203a20
.long 0xe7203720
.long 0x3a202c20
.long 0x37203720
.long 0x28203520
.long 0xe7202620
.long 0x32203020
.long 0xf0201e20
.long 0x31202620
.long 0x2f202820
.long 0x19203820
.long 0x31202620
.long 0x2b20ee03
.long 0x203a203a
.long 0x203a20e7
.long 0x20332024
.long 0x20372035
.long 0x20282032
.long 0x203120e7
.long 0x20262032
.long 0x203020f0
.long 0x201e2031
.long 0x2026202f
.long 0x20282019
.long 0x20382031
.long 0x2026202b
.long 0x19000000


FunctionStart:

branchl	r12,0x803a6368

#Check For TM Credits
load	r5,0x80479D30
lbz	r5,0x0(r5)
cmpwi	r5,0x1
bne	Exit

backup

#Check If The Last Block of Text
lwz	r3, -0x4eac (r13)
cmpwi	r3,0xC0 			#Was Originally 0xC4
bne	CheckWhitelist
bl	FinalMessage
mflr	r4
addi	r4,r4,0x2
#Store To Text Struct
lwz	r3, -0x4EA8 (r13)
lwzx	r3, r3, r31
stw	r4,0x5C(r3)
b	CustomExit

#Only Display After the First 2 Names
CheckWhitelist:
lwz	r3, -0x4eac (r13)
cmpwi	r3,0x1
ble	CustomExit
cmpwi	r3,193
bge	CustomExit

ConvertToMenuText:
#Get Text As Menu Text
li	r3,128
branchl	r12,0x803a5798
mr	r20,r3
bl	Names
mflr	r4
lwz	r5, -0x4eac (r13)
subi	r5,r5,0x2
mulli	r5,r5,0xC
add	r4,r4,r5
branchl	r12,0x803a67ec


#Store To Text Struct
lwz	r3, -0x4EA8 (r13)
lwzx	r3, r3, r31
stw	r20,0x5C(r3)

CustomExit:
#Inc Name Count
lwz	r3, -0x4eac (r13)
addi	r3,r3,0x1
stw	r3, -0x4eac (r13)

restore
b	Exit



Exit:
mtctr	r12

