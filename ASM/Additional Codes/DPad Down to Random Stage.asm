#To be inserted at 8026325c
.include "D:/Users/Vin/Documents/GitHub/Training-Mode/ASM/Globals.s"

#Get Random Stage Byte
load r4,0x8045BF17

#Check for DPad Down
  rlwinm.	r0, r7, 0, 29, 29
  beq Exit
  li r3,0x1
  stb r3,0x0(r4)
  branch r12,0x80263264

#Check for Start
  rlwinm.	r0, r7, 0, 19, 19
  beq Exit
  li r3,0x0
  stb r3,0x0(r4)

#Original Codeline
Exit:
  rlwinm.	r0, r7, 0, 19, 19
