
========================================================================

** ELF Header Information

    File Name: .\Objects\gpio.axf

    Machine class: ELFCLASS32 (32-bit)
    Data encoding: ELFDATA2LSB (Little endian)
    Header version: EV_CURRENT (Current version)
    Operating System ABI: none
    ABI Version: 0
    File Type: ET_EXEC (Executable) (2)
    Machine: EM_ARM (ARM)

    Image Entry point: 0x10002155
    Flags: EF_ARM_HASENTRY (0x05000002)

    ARM ELF revision: 5 (ABI version 2)

    Conforms to Base float procedure-call standard

    Built with
    Component: Arm Compiler for Embedded 6.24 Tool: armasm [5f371400]
    Component: Arm Compiler for Embedded 6.24 Tool: armlink [5f371500]

    Header size: 52 bytes (0x34)
    Program header entry size: 32 bytes (0x20)
    Section header entry size: 40 bytes (0x28)

    Program header entries: 2
    Section header entries: 21

    Program header offset: 116516 (0x0001c724)
    Section header offset: 116580 (0x0001c764)

    Section header string table index: 20

========================================================================

** Program header #0 (PT_LOAD) [PF_R]
    Size : 4096 bytes
    Virtual address: 0x10000000 (Alignment 4)


====================================

** Program header #1 (PT_LOAD) [PF_X + PF_W + PF_R + PF_ARM_ENTRY]
    Size : 15584 bytes (10868 bytes in file)
    Virtual address: 0x10002000 (Alignment 512)


========================================================================

** Section #1 'BOOT2_CODE' (SHT_PROGBITS) [SHF_ALLOC]
    Size   : 4096 bytes
    Address: 0x10000000


** Section #2 'INIT' (SHT_PROGBITS) [SHF_ALLOC + SHF_EXECINSTR]
    Size   : 752 bytes (alignment 4)
    Address: 0x10002000

    $d.realdata
    RESET
    __Vectors
        0x10002000:    20010000    ...     DCD    536936448
        0x10002004:    10002155    U!..    DCD    268443989
        0x10002008:    10002169    i!..    DCD    268444009
        0x1000200c:    1000217b    {!..    DCD    268444027
        0x10002010:    1000218d    .!..    DCD    268444045
        0x10002014:    1000218f    .!..    DCD    268444047
        0x10002018:    10002191    .!..    DCD    268444049
        0x1000201c:    00000000    ....    DCD    0
        0x10002020:    00000000    ....    DCD    0
        0x10002024:    00000000    ....    DCD    0
        0x10002028:    00000000    ....    DCD    0
        0x1000202c:    000002d1    ....    DCD    721
        0x10002030:    10002195    .!..    DCD    268444053
        0x10002034:    00000000    ....    DCD    0
        0x10002038:    00000375    u...    DCD    885
        0x1000203c:    00000381    ....    DCD    897
        0x10002040:    1000219b    .!..    DCD    268444059
        0x10002044:    1000219d    .!..    DCD    268444061
        0x10002048:    1000219f    .!..    DCD    268444063
        0x1000204c:    100021a1    .!..    DCD    268444065
        0x10002050:    100021a3    .!..    DCD    268444067
        0x10002054:    100021a5    .!..    DCD    268444069
        0x10002058:    100021a7    .!..    DCD    268444071
        0x1000205c:    100021a9    .!..    DCD    268444073
        0x10002060:    100021ab    .!..    DCD    268444075
        0x10002064:    100021ad    .!..    DCD    268444077
        0x10002068:    100021af    .!..    DCD    268444079
        0x1000206c:    100021b1    .!..    DCD    268444081
        0x10002070:    100021b3    .!..    DCD    268444083
        0x10002074:    100021b5    .!..    DCD    268444085
        0x10002078:    100021b7    .!..    DCD    268444087
        0x1000207c:    100021b9    .!..    DCD    268444089
        0x10002080:    100021bb    .!..    DCD    268444091
        0x10002084:    100021bd    .!..    DCD    268444093
        0x10002088:    100021bf    .!..    DCD    268444095
        0x1000208c:    100021c1    .!..    DCD    268444097
        0x10002090:    100021c3    .!..    DCD    268444099
        0x10002094:    100021c5    .!..    DCD    268444101
        0x10002098:    100021c7    .!..    DCD    268444103
        0x1000209c:    100021c9    .!..    DCD    268444105
        0x100020a0:    100021cb    .!..    DCD    268444107
        0x100020a4:    100021cd    .!..    DCD    268444109
        0x100020a8:    100021cf    .!..    DCD    268444111
        0x100020ac:    100021d1    .!..    DCD    268444113
        0x100020b0:    100021d3    .!..    DCD    268444115
        0x100020b4:    100021d5    .!..    DCD    268444117
        0x100020b8:    100021d7    .!..    DCD    268444119
        0x100020bc:    100021d9    .!..    DCD    268444121
        0x100020c0:    100021db    .!..    DCD    268444123
        0x100020c4:    100021dd    .!..    DCD    268444125
        0x100020c8:    100021df    .!..    DCD    268444127
        0x100020cc:    100021e1    .!..    DCD    268444129
        0x100020d0:    2000326d    m2.     DCD    536883821
        0x100020d4:    100021e5    .!..    DCD    268444133
        0x100020d8:    100021e7    .!..    DCD    268444135
        0x100020dc:    100021e9    .!..    DCD    268444137
        0x100020e0:    100021eb    .!..    DCD    268444139
        0x100020e4:    100021ed    .!..    DCD    268444141
        0x100020e8:    100021ef    .!..    DCD    268444143
        0x100020ec:    100021f1    .!..    DCD    268444145
        0x100020f0:    100021f3    .!..    DCD    268444147
        0x100020f4:    100021f5    .!..    DCD    268444149
        0x100020f8:    100021f7    .!..    DCD    268444151
        0x100020fc:    100021f9    .!..    DCD    268444153
        0x10002100:    100021fb    .!..    DCD    268444155
        0x10002104:    20003201    .2.     DCD    536883713
        0x10002108:    100021ff    .!..    DCD    268444159
        0x1000210c:    10002201    ."..    DCD    268444161
        0x10002110:    10002203    ."..    DCD    268444163
        0x10002114:    10002205    ."..    DCD    268444165
        0x10002118:    10002207    ."..    DCD    268444167
        0x1000211c:    10002209    ."..    DCD    268444169
        0x10002120:    1000220b    ."..    DCD    268444171
        0x10002124:    1000220d    ."..    DCD    268444173
        0x10002128:    1000220f    ."..    DCD    268444175
        0x1000212c:    00000000    ....    DCD    0
        0x10002130:    00000000    ....    DCD    0
        0x10002134:    00000000    ....    DCD    0
        0x10002138:    00000000    ....    DCD    0
        0x1000213c:    00000000    ....    DCD    0
    $t
    .ARM.Collect$$$$00000000
    .ARM.Collect$$$$00000001
    __Vectors_End
    __main
    _main_stk
        0x10002140:    f8dfd00c    ....    LDR      sp,__lit__00000000 ; [0x10002150] = 0x20010000
    .ARM.Collect$$$$00000004
    _main_scatterload
        0x10002144:    f000f870    ..p.    BL       __scatterload ; 0x10002228
    .ARM.Collect$$$$00000008
    .ARM.Collect$$$$0000000A
    .ARM.Collect$$$$0000000B
    __main_after_scatterload
    _main_clock
    _main_cpp_init
    _main_init
        0x10002148:    4800        .H      LDR      r0,[pc,#0] ; [0x1000214c] = 0x100036f5
        0x1000214a:    4700        .G      BX       r0
    $d
        0x1000214c:    100036f5    .6..    DCD    268449525
    .ARM.Collect$$$$00002712
    __lit__00000000
    .ARM.Collect$$$$0000000D
    .ARM.Collect$$$$0000000F
    __rt_final_cpp
    __rt_final_exit
        0x10002150:    20010000    ...     DCD    536936448
    $t
    .text
    $v0
    Reset_Handler
        0x10002154:    482e        .H      LDR      r0,[pc,#184] ; [0x10002210] = 0x20010000
        0x10002156:    f3808808    ....    MSR      MSP,r0
        0x1000215a:    482e        .H      LDR      r0,[pc,#184] ; [0x10002214] = 0x2000f000
        0x1000215c:    f380880a    ....    MSR      MSPLIM,r0
        0x10002160:    482d        -H      LDR      r0,[pc,#180] ; [0x10002218] = 0x10002259
        0x10002162:    4780        .G      BLX      r0
        0x10002164:    482d        -H      LDR      r0,[pc,#180] ; [0x1000221c] = 0x10002141
        0x10002166:    4700        .G      BX       r0
    NMI_Handler
        0x10002168:    ea5f000e    _...    MOVS     r0,lr
        0x1000216c:    f3ef8108    ....    MRS      r1,MSP
        0x10002170:    f3ef8209    ....    MRS      r2,PSP
        0x10002174:    4b2a        *K      LDR      r3,[pc,#168] ; [0x10002220] = 0x10003419
        0x10002176:    4798        .G      BLX      r3
        0x10002178:    e7fe        ..      B        0x10002178 ; NMI_Handler + 16
    HardFault_Handler
        0x1000217a:    ea5f000e    _...    MOVS     r0,lr
        0x1000217e:    f3ef8108    ....    MRS      r1,MSP
        0x10002182:    f3ef8209    ....    MRS      r2,PSP
        0x10002186:    4b27        'K      LDR      r3,[pc,#156] ; [0x10002224] = 0x10002a3d
        0x10002188:    4798        .G      BLX      r3
        0x1000218a:    e7fe        ..      B        0x1000218a ; HardFault_Handler + 16
    MemoryManagement_Handler
        0x1000218c:    e7fe        ..      B        MemoryManagement_Handler ; 0x1000218c
    BusFault_Handler
        0x1000218e:    e7fe        ..      B        BusFault_Handler ; 0x1000218e
    UsageFault_Handler
        0x10002190:    e7fe        ..      B        UsageFault_Handler ; 0x10002190
        0x10002192:    e7fe        ..      B        0x10002192 ; UsageFault_Handler + 2
    DebugMon_Handler
        0x10002194:    e7fe        ..      B        DebugMon_Handler ; 0x10002194
        0x10002196:    e7fe        ..      B        0x10002196 ; DebugMon_Handler + 2
        0x10002198:    e7fe        ..      B        0x10002198 ; DebugMon_Handler + 4
    RTC_CH0_IRQ_Handler
        0x1000219a:    e7fe        ..      B        RTC_CH0_IRQ_Handler ; 0x1000219a
    GPADC0_IRQ_Handler
        0x1000219c:    e7fe        ..      B        GPADC0_IRQ_Handler ; 0x1000219c
    LLC_IRQ_Handler
        0x1000219e:    e7fe        ..      B        LLC_IRQ_Handler ; 0x1000219e
    I2S_IRQ_Handler
        0x100021a0:    e7fe        ..      B        I2S_IRQ_Handler ; 0x100021a0
    QDEC_IRQ_Handler
        0x100021a2:    e7fe        ..      B        QDEC_IRQ_Handler ; 0x100021a2
    AUDIO0_IRQ_Handler
        0x100021a4:    e7fe        ..      B        AUDIO0_IRQ_Handler ; 0x100021a4
    CRYPT0_IRQ_Handler
        0x100021a6:    e7fe        ..      B        CRYPT0_IRQ_Handler ; 0x100021a6
    TRNG_IRQ_Handler
        0x100021a8:    e7fe        ..      B        TRNG_IRQ_Handler ; 0x100021a8
    RF_CAL_IRQ_Handler
        0x100021aa:    e7fe        ..      B        RF_CAL_IRQ_Handler ; 0x100021aa
    UART0_IRQ_Handler
        0x100021ac:    e7fe        ..      B        UART0_IRQ_Handler ; 0x100021ac
    UART1_IRQ_Handler
        0x100021ae:    e7fe        ..      B        UART1_IRQ_Handler ; 0x100021ae
    UART2_IRQ_Handler
        0x100021b0:    e7fe        ..      B        UART2_IRQ_Handler ; 0x100021b0
    SPI0_IRQ_Handler
        0x100021b2:    e7fe        ..      B        SPI0_IRQ_Handler ; 0x100021b2
    SPI1_IRQ_Handler
        0x100021b4:    e7fe        ..      B        SPI1_IRQ_Handler ; 0x100021b4
    I2C0_IRQ_Handler
        0x100021b6:    e7fe        ..      B        I2C0_IRQ_Handler ; 0x100021b6
    I2C1_IRQ_Handler
        0x100021b8:    e7fe        ..      B        I2C1_IRQ_Handler ; 0x100021b8
    I2C2_IRQ_Handler
        0x100021ba:    e7fe        ..      B        I2C2_IRQ_Handler ; 0x100021ba
    DMA_IRQ0_Handler
        0x100021bc:    e7fe        ..      B        DMA_IRQ0_Handler ; 0x100021bc
    DMA_IRQ4_Handler
        0x100021be:    e7fe        ..      B        DMA_IRQ4_Handler ; 0x100021be
    TIMER0_IRQ_Handler
        0x100021c0:    e7fe        ..      B        TIMER0_IRQ_Handler ; 0x100021c0
    GPIO_IRQ0_Handler
        0x100021c2:    e7fe        ..      B        GPIO_IRQ0_Handler ; 0x100021c2
    GPIO_IRQ1_Handler
        0x100021c4:    e7fe        ..      B        GPIO_IRQ1_Handler ; 0x100021c4
    GPIO_IRQ2_Handler
        0x100021c6:    e7fe        ..      B        GPIO_IRQ2_Handler ; 0x100021c6
    PMU_IRQ_Handler
        0x100021c8:    e7fe        ..      B        PMU_IRQ_Handler ; 0x100021c8
    QSPI0_IRQ_Handler
        0x100021ca:    e7fe        ..      B        QSPI0_IRQ_Handler ; 0x100021ca
    QSPI1_IRQ_Handler
        0x100021cc:    e7fe        ..      B        QSPI1_IRQ_Handler ; 0x100021cc
    QSPI2_IRQ_Handler
        0x100021ce:    e7fe        ..      B        QSPI2_IRQ_Handler ; 0x100021ce
    QSPI3_IRQ_Handler
        0x100021d0:    e7fe        ..      B        QSPI3_IRQ_Handler ; 0x100021d0
    SW_IRQ0_Handler
        0x100021d2:    e7fe        ..      B        SW_IRQ0_Handler ; 0x100021d2
    SW_IRQ1_Handler
        0x100021d4:    e7fe        ..      B        SW_IRQ1_Handler ; 0x100021d4
    USB_IRQ_Handler
        0x100021d6:    e7fe        ..      B        USB_IRQ_Handler ; 0x100021d6
    RTC_CH3_IRQ_Handler
        0x100021d8:    e7fe        ..      B        RTC_CH3_IRQ_Handler ; 0x100021d8
    DMA_IRQ1_Handler
        0x100021da:    e7fe        ..      B        DMA_IRQ1_Handler ; 0x100021da
    DMA_IRQ2_Handler
        0x100021dc:    e7fe        ..      B        DMA_IRQ2_Handler ; 0x100021dc
    DMA_IRQ3_Handler
        0x100021de:    e7fe        ..      B        DMA_IRQ3_Handler ; 0x100021de
    DMA_IRQ5_Handler
        0x100021e0:    e7fe        ..      B        DMA_IRQ5_Handler ; 0x100021e0
        0x100021e2:    e7fe        ..      B        0x100021e2 ; DMA_IRQ5_Handler + 2
    DMA_IRQ7_Handler
        0x100021e4:    e7fe        ..      B        DMA_IRQ7_Handler ; 0x100021e4
    TIMER1_IRQ_Handler
        0x100021e6:    e7fe        ..      B        TIMER1_IRQ_Handler ; 0x100021e6
    TIMER2_IRQ_Handler
        0x100021e8:    e7fe        ..      B        TIMER2_IRQ_Handler ; 0x100021e8
    TIMER3_IRQ_Handler
        0x100021ea:    e7fe        ..      B        TIMER3_IRQ_Handler ; 0x100021ea
    SW_IRQ2_Handler
        0x100021ec:    e7fe        ..      B        SW_IRQ2_Handler ; 0x100021ec
    FP_IRQ_Handler
        0x100021ee:    e7fe        ..      B        FP_IRQ_Handler ; 0x100021ee
    RTC_CH1_IRQ_Handler
        0x100021f0:    e7fe        ..      B        RTC_CH1_IRQ_Handler ; 0x100021f0
    RTC_CH2_IRQ_Handler
        0x100021f2:    e7fe        ..      B        RTC_CH2_IRQ_Handler ; 0x100021f2
    AUDIO1_IRQ_Handler
        0x100021f4:    e7fe        ..      B        AUDIO1_IRQ_Handler ; 0x100021f4
    GPADC1_IRQ_Handler
        0x100021f6:    e7fe        ..      B        GPADC1_IRQ_Handler ; 0x100021f6
    I2C3_IRQ_Handler
        0x100021f8:    e7fe        ..      B        I2C3_IRQ_Handler ; 0x100021f8
    USB_PHY_IRQ_Handler
        0x100021fa:    e7fe        ..      B        USB_PHY_IRQ_Handler ; 0x100021fa
        0x100021fc:    e7fe        ..      B        0x100021fc ; USB_PHY_IRQ_Handler + 2
    STIM0_IRQ1_Handler
        0x100021fe:    e7fe        ..      B        STIM0_IRQ1_Handler ; 0x100021fe
    STIM0_IRQ2_Handler
        0x10002200:    e7fe        ..      B        STIM0_IRQ2_Handler ; 0x10002200
    STIM0_IRQ3_Handler
        0x10002202:    e7fe        ..      B        STIM0_IRQ3_Handler ; 0x10002202
    STIM1_IRQ0_Handler
        0x10002204:    e7fe        ..      B        STIM1_IRQ0_Handler ; 0x10002204
    STIM1_IRQ1_Handler
        0x10002206:    e7fe        ..      B        STIM1_IRQ1_Handler ; 0x10002206
    STIM1_IRQ2_Handler
        0x10002208:    e7fe        ..      B        STIM1_IRQ2_Handler ; 0x10002208
    STIM1_IRQ3_Handler
        0x1000220a:    e7fe        ..      B        STIM1_IRQ3_Handler ; 0x1000220a
    WDT1_IRQ_Handler
        0x1000220c:    e7fe        ..      B        WDT1_IRQ_Handler ; 0x1000220c
    CRYPT1_IRQ_Handler
        0x1000220e:    e7fe        ..      B        CRYPT1_IRQ_Handler ; 0x1000220e
    $d
        0x10002210:    20010000    ...     DCD    536936448
        0x10002214:    2000f000    ...     DCD    536932352
        0x10002218:    10002259    Y"..    DCD    268444249
        0x1000221c:    10002141    A!..    DCD    268443969
        0x10002220:    10003419    .4..    DCD    268448793
        0x10002224:    10002a3d    =*..    DCD    268446269
    $t
    .text
    __scatterload
    __scatterload_rt2
        0x10002228:    b51c        ..      PUSH     {r2-r4,lr}
        0x1000222a:    4809        .H      LDR      r0,[pc,#36] ; [0x10002250] = 0x100022c0
        0x1000222c:    9000        ..      STR      r0,[sp,#0]
        0x1000222e:    4809        .H      LDR      r0,[pc,#36] ; [0x10002254] = 0x100022f0
        0x10002230:    9001        ..      STR      r0,[sp,#4]
        0x10002232:    4605        .F      MOV      r5,r0
        0x10002234:    9c00        ..      LDR      r4,[sp,#0]
        0x10002236:    e006        ..      B        0x10002246 ; __scatterload + 30
        0x10002238:    68e0        .h      LDR      r0,[r4,#0xc]
        0x1000223a:    f0400301    @...    ORR      r3,r0,#1
        0x1000223e:    e8940007    ....    LDM      r4,{r0-r2}
        0x10002242:    4798        .G      BLX      r3
        0x10002244:    3410        .4      ADDS     r4,r4,#0x10
        0x10002246:    42ac        .B      CMP      r4,r5
        0x10002248:    d3f6        ..      BCC      0x10002238 ; __scatterload + 16
        0x1000224a:    f7ffff7d    ..}.    BL       __main_after_scatterload ; 0x10002148
    $d
        0x1000224e:    0000        ..      DCW    0
        0x10002250:    100022c0    ."..    DCD    268444352
        0x10002254:    100022f0    ."..    DCD    268444400
    $t
    SystemInit
        0x10002258:    f2420200    B...    MOVW     r2,#0x2000
        0x1000225c:    f2430100    C...    MOVW     r1,#0x3000
        0x10002260:    2000        .       MOVS     r0,#0
        0x10002262:    f2c10200    ....    MOVT     r2,#0x1000
        0x10002266:    f2c20100    ....    MOVT     r1,#0x2000
        0x1000226a:    bf00        ..      NOP      
        0x1000226c:    f8523020    R. 0    LDR      r3,[r2,r0,LSL #2]
        0x10002270:    f8413020    A. 0    STR      r3,[r1,r0,LSL #2]
        0x10002274:    3001        .0      ADDS     r0,#1
        0x10002276:    284b        K(      CMP      r0,#0x4b
        0x10002278:    d1f8        ..      BNE      0x1000226c ; SystemInit + 20
        0x1000227a:    f64e5014    N..P    MOV      r0,#0xed14
        0x1000227e:    f2ce0000    ....    MOVT     r0,#0xe000
        0x10002282:    f8401c0c    @...    STR      r1,[r0,#-0xc]
        0x10002286:    6f41        Ao      LDR      r1,[r0,#0x74]
        0x10002288:    f4410170    A.p.    ORR      r1,r1,#0xf00000
        0x1000228c:    6741        Ag      STR      r1,[r0,#0x74]
        0x1000228e:    6801        .h      LDR      r1,[r0,#0]
        0x10002290:    f0410110    A...    ORR      r1,r1,#0x10
        0x10002294:    6001        .`      STR      r1,[r0,#0]
        0x10002296:    6801        .h      LDR      r1,[r0,#0]
        0x10002298:    f4417180    A..q    ORR      r1,r1,#0x100
        0x1000229c:    6001        .`      STR      r1,[r0,#0]
        0x1000229e:    4770        pG      BX       lr
    i.__scatterload_copy
    __scatterload_copy
        0x100022a0:    e002        ..      B        0x100022a8 ; __scatterload_copy + 8
        0x100022a2:    c808        ..      LDM      r0!,{r3}
        0x100022a4:    1f12        ..      SUBS     r2,r2,#4
        0x100022a6:    c108        ..      STM      r1!,{r3}
        0x100022a8:    2a00        .*      CMP      r2,#0
        0x100022aa:    d1fa        ..      BNE      0x100022a2 ; __scatterload_copy + 2
        0x100022ac:    4770        pG      BX       lr
    i.__scatterload_null
    __scatterload_null
        0x100022ae:    4770        pG      BX       lr
    i.__scatterload_zeroinit
    __scatterload_zeroinit
        0x100022b0:    2000        .       MOVS     r0,#0
        0x100022b2:    e001        ..      B        0x100022b8 ; __scatterload_zeroinit + 8
        0x100022b4:    c101        ..      STM      r1!,{r0}
        0x100022b6:    1f12        ..      SUBS     r2,r2,#4
        0x100022b8:    2a00        .*      CMP      r2,#0
        0x100022ba:    d1fb        ..      BNE      0x100022b4 ; __scatterload_zeroinit + 4
        0x100022bc:    4770        pG      BX       lr
        0x100022be:    0000        ..      MOVS     r0,r0
    $d.realdata
    Region$$Table$$Base
        0x100022c0:    1000493c    <I..    DCD    268454204
        0x100022c4:    20003200    .2.     DCD    536883712
        0x100022c8:    00000130    0...    DCD    304
        0x100022cc:    100022a0    ."..    DCD    268444320
        0x100022d0:    10004a6c    lJ..    DCD    268454508
        0x100022d4:    2000b000    ...     DCD    536915968
        0x100022d8:    00000008    ....    DCD    8
        0x100022dc:    100022a0    ."..    DCD    268444320
        0x100022e0:    10004a74    tJ..    DCD    268454516
        0x100022e4:    2000b008    ...     DCD    536915976
        0x100022e8:    00000078    x...    DCD    120
        0x100022ec:    100022b0    ."..    DCD    268444336
    Region$$Table$$Limit

** Section #3 'FLASH_CACHE_CODE' (SHT_PROGBITS) [SHF_ALLOC + SHF_EXECINSTR]
    Size   : 9804 bytes (alignment 4)
    Address: 0x100022f0

    $t
    .text
    __aeabi_f2d
        0x100022f0:    f0004200    ...B    AND      r2,r0,#0x80000000
        0x100022f4:    f0304000    0..@    BICS     r0,r0,#0x80000000
        0x100022f8:    d00a        ..      BEQ      0x10002310 ; __aeabi_f2d + 32
        0x100022fa:    0dc1        ..      LSRS     r1,r0,#23
        0x100022fc:    f5017160    ..`q    ADD      r1,r1,#0x380
        0x10002300:    f3c00016    ....    UBFX     r0,r0,#0,#23
        0x10002304:    ea425101    B..Q    ORR      r1,r2,r1,LSL #20
        0x10002308:    08c2        ..      LSRS     r2,r0,#3
        0x1000230a:    0740        @.      LSLS     r0,r0,#29
        0x1000230c:    4311        .C      ORRS     r1,r1,r2
        0x1000230e:    4770        pG      BX       lr
        0x10002310:    2000        .       MOVS     r0,#0
        0x10002312:    4601        .F      MOV      r1,r0
        0x10002314:    4770        pG      BX       lr
    .text
    __aeabi_uidiv
    __aeabi_uidivmod
        0x10002316:    b530        0.      PUSH     {r4,r5,lr}
        0x10002318:    460b        .F      MOV      r3,r1
        0x1000231a:    4601        .F      MOV      r1,r0
        0x1000231c:    2000        .       MOVS     r0,#0
        0x1000231e:    2220         "      MOVS     r2,#0x20
        0x10002320:    2401        .$      MOVS     r4,#1
        0x10002322:    e009        ..      B        0x10002338 ; __aeabi_uidiv + 34
        0x10002324:    fa21f502    !...    LSR      r5,r1,r2
        0x10002328:    429d        .B      CMP      r5,r3
        0x1000232a:    d305        ..      BCC      0x10002338 ; __aeabi_uidiv + 34
        0x1000232c:    fa03f502    ....    LSL      r5,r3,r2
        0x10002330:    1b49        I.      SUBS     r1,r1,r5
        0x10002332:    fa04f502    ....    LSL      r5,r4,r2
        0x10002336:    4428        (D      ADD      r0,r0,r5
        0x10002338:    1e15        ..      SUBS     r5,r2,#0
        0x1000233a:    f1a20201    ....    SUB      r2,r2,#1
        0x1000233e:    dcf1        ..      BGT      0x10002324 ; __aeabi_uidiv + 14
        0x10002340:    bd30        0.      POP      {r4,r5,pc}
    .text
    __aeabi_uldivmod
        0x10002342:    e92d5ff0    -.._    PUSH     {r4-r12,lr}
        0x10002346:    4605        .F      MOV      r5,r0
        0x10002348:    2000        .       MOVS     r0,#0
        0x1000234a:    4692        .F      MOV      r10,r2
        0x1000234c:    469b        .F      MOV      r11,r3
        0x1000234e:    4688        .F      MOV      r8,r1
        0x10002350:    4606        .F      MOV      r6,r0
        0x10002352:    4681        .F      MOV      r9,r0
        0x10002354:    2440        @$      MOVS     r4,#0x40
        0x10002356:    e01b        ..      B        0x10002390 ; __aeabi_uldivmod + 78
        0x10002358:    4628        (F      MOV      r0,r5
        0x1000235a:    4641        AF      MOV      r1,r8
        0x1000235c:    4647        GF      MOV      r7,r8
        0x1000235e:    4622        "F      MOV      r2,r4
        0x10002360:    f000f9e7    ....    BL       __aeabi_llsr ; 0x10002732
        0x10002364:    4653        SF      MOV      r3,r10
        0x10002366:    465a        ZF      MOV      r2,r11
        0x10002368:    1ac0        ..      SUBS     r0,r0,r3
        0x1000236a:    4191        .A      SBCS     r1,r1,r2
        0x1000236c:    d310        ..      BCC      0x10002390 ; __aeabi_uldivmod + 78
        0x1000236e:    4611        .F      MOV      r1,r2
        0x10002370:    4618        .F      MOV      r0,r3
        0x10002372:    4622        "F      MOV      r2,r4
        0x10002374:    f000f9ce    ....    BL       __aeabi_llsl ; 0x10002714
        0x10002378:    1a2d        -.      SUBS     r5,r5,r0
        0x1000237a:    eb670801    g...    SBC      r8,r7,r1
        0x1000237e:    464f        OF      MOV      r7,r9
        0x10002380:    4622        "F      MOV      r2,r4
        0x10002382:    2001        .       MOVS     r0,#1
        0x10002384:    2100        .!      MOVS     r1,#0
        0x10002386:    f000f9c5    ....    BL       __aeabi_llsl ; 0x10002714
        0x1000238a:    eb170900    ....    ADDS     r9,r7,r0
        0x1000238e:    414e        NA      ADCS     r6,r6,r1
        0x10002390:    1e20         .      SUBS     r0,r4,#0
        0x10002392:    f1a40401    ....    SUB      r4,r4,#1
        0x10002396:    dcdf        ..      BGT      0x10002358 ; __aeabi_uldivmod + 22
        0x10002398:    4648        HF      MOV      r0,r9
        0x1000239a:    4631        1F      MOV      r1,r6
        0x1000239c:    462a        *F      MOV      r2,r5
        0x1000239e:    4643        CF      MOV      r3,r8
        0x100023a0:    e8bd9ff0    ....    POP      {r4-r12,pc}
    .text
    .text
    __I$use$fp
    __aeabi_dadd
        0x100023a4:    e92d4ffe    -..O    PUSH     {r1-r11,lr}
        0x100023a8:    4680        .F      MOV      r8,r0
        0x100023aa:    ea810003    ....    EOR      r0,r1,r3
        0x100023ae:    0fc0        ..      LSRS     r0,r0,#31
        0x100023b0:    460c        .F      MOV      r4,r1
        0x100023b2:    9000        ..      STR      r0,[sp,#0]
        0x100023b4:    f0214100    !..A    BIC      r1,r1,#0x80000000
        0x100023b8:    f0234500    #..E    BIC      r5,r3,#0x80000000
        0x100023bc:    ebb80002    ....    SUBS     r0,r8,r2
        0x100023c0:    41a9        .A      SBCS     r1,r1,r5
        0x100023c2:    d205        ..      BCS      0x100023d0 ; __I$use$fp + 44
        0x100023c4:    4640        @F      MOV      r0,r8
        0x100023c6:    4621        !F      MOV      r1,r4
        0x100023c8:    4690        .F      MOV      r8,r2
        0x100023ca:    461c        .F      MOV      r4,r3
        0x100023cc:    460b        .F      MOV      r3,r1
        0x100023ce:    4602        .F      MOV      r2,r0
        0x100023d0:    f0234000    #..@    BIC      r0,r3,#0x80000000
        0x100023d4:    4310        .C      ORRS     r0,r0,r2
        0x100023d6:    d047        G.      BEQ      0x10002468 ; __I$use$fp + 196
        0x100023d8:    0d27        '.      LSRS     r7,r4,#20
        0x100023da:    f3c7000a    ....    UBFX     r0,r7,#0,#11
        0x100023de:    f3c3510a    ...Q    UBFX     r1,r3,#20,#11
        0x100023e2:    9002        ..      STR      r0,[sp,#8]
        0x100023e4:    1a40        @.      SUBS     r0,r0,r1
        0x100023e6:    9001        ..      STR      r0,[sp,#4]
        0x100023e8:    2840        @(      CMP      r0,#0x40
        0x100023ea:    da6b        k.      BGE      0x100024c4 ; __I$use$fp + 288
        0x100023ec:    f3c30013    ....    UBFX     r0,r3,#0,#20
        0x100023f0:    f4401b80    @...    ORR      r11,r0,#0x100000
        0x100023f4:    9800        ..      LDR      r0,[sp,#0]
        0x100023f6:    4692        .F      MOV      r10,r2
        0x100023f8:    b120         .      CBZ      r0,0x10002404 ; __I$use$fp + 96
        0x100023fa:    2300        .#      MOVS     r3,#0
        0x100023fc:    ebd20a03    ....    RSBS     r10,r2,r3
        0x10002400:    eb630b0b    c...    SBC      r11,r3,r11
        0x10002404:    9801        ..      LDR      r0,[sp,#4]
        0x10002406:    4659        YF      MOV      r1,r11
        0x10002408:    f1c00240    ..@.    RSB      r2,r0,#0x40
        0x1000240c:    4650        PF      MOV      r0,r10
        0x1000240e:    f000f981    ....    BL       __aeabi_llsl ; 0x10002714
        0x10002412:    4606        .F      MOV      r6,r0
        0x10002414:    460d        .F      MOV      r5,r1
        0x10002416:    4650        PF      MOV      r0,r10
        0x10002418:    4659        YF      MOV      r1,r11
        0x1000241a:    9a01        ..      LDR      r2,[sp,#4]
        0x1000241c:    f000f999    ....    BL       __aeabi_lasr ; 0x10002752
        0x10002420:    eb100008    ....    ADDS     r0,r0,r8
        0x10002424:    4161        aA      ADCS     r1,r1,r4
        0x10002426:    2400        .$      MOVS     r4,#0
        0x10002428:    ea875211    ...R    EOR      r2,r7,r1,LSR #20
        0x1000242c:    ea8473e7    ...s    EOR      r3,r4,r7,ASR #31
        0x10002430:    431a        .C      ORRS     r2,r2,r3
        0x10002432:    d040        @.      BEQ      0x100024b6 ; __I$use$fp + 274
        0x10002434:    9a00        ..      LDR      r2,[sp,#0]
        0x10002436:    b362        b.      CBZ      r2,0x10002492 ; __I$use$fp + 238
        0x10002438:    9a01        ..      LDR      r2,[sp,#4]
        0x1000243a:    2a01        .*      CMP      r2,#1
        0x1000243c:    ea4f5207    O..R    LSL      r2,r7,#20
        0x10002440:    dc15        ..      BGT      0x1000246e ; __I$use$fp + 202
        0x10002442:    1b00        ..      SUBS     r0,r0,r4
        0x10002444:    eb610102    a...    SBC      r1,r1,r2
        0x10002448:    f04f4200    O..B    MOV      r2,#0x80000000
        0x1000244c:    ea025207    ...R    AND      r2,r2,r7,LSL #20
        0x10002450:    e9cd4200    ...B    STRD     r4,r2,[sp,#0]
        0x10002454:    1c00        ..      ADDS     r0,r0,#0
        0x10002456:    f5411180    A...    ADC      r1,r1,#0x100000
        0x1000245a:    4632        2F      MOV      r2,r6
        0x1000245c:    462b        +F      MOV      r3,r5
        0x1000245e:    f000f999    ....    BL       _double_epilogue ; 0x10002794
        0x10002462:    b003        ..      ADD      sp,sp,#0xc
        0x10002464:    e8bd8ff0    ....    POP      {r4-r11,pc}
        0x10002468:    4640        @F      MOV      r0,r8
        0x1000246a:    4621        !F      MOV      r1,r4
        0x1000246c:    e7f9        ..      B        0x10002462 ; __I$use$fp + 190
        0x1000246e:    1b00        ..      SUBS     r0,r0,r4
        0x10002470:    eb610102    a...    SBC      r1,r1,r2
        0x10002474:    1c00        ..      ADDS     r0,r0,#0
        0x10002476:    f5411380    A...    ADC      r3,r1,#0x100000
        0x1000247a:    1800        ..      ADDS     r0,r0,r0
        0x1000247c:    415b        [A      ADCS     r3,r3,r3
        0x1000247e:    1820         .      ADDS     r0,r4,r0
        0x10002480:    f5a21700    ....    SUB      r7,r2,#0x200000
        0x10002484:    eb470103    G...    ADC      r1,r7,r3
        0x10002488:    ea4070d5    @..p    ORR      r0,r0,r5,LSR #31
        0x1000248c:    19b6        ..      ADDS     r6,r6,r6
        0x1000248e:    416d        mA      ADCS     r5,r5,r5
        0x10002490:    e011        ..      B        0x100024b6 ; __I$use$fp + 274
        0x10002492:    086d        m.      LSRS     r5,r5,#1
        0x10002494:    ea4f0636    O.6.    RRX      r6,r6
        0x10002498:    ea4575c0    E..u    ORR      r5,r5,r0,LSL #31
        0x1000249c:    ea4f5207    O..R    LSL      r2,r7,#20
        0x100024a0:    1b00        ..      SUBS     r0,r0,r4
        0x100024a2:    eb610102    a...    SBC      r1,r1,r2
        0x100024a6:    1c00        ..      ADDS     r0,r0,#0
        0x100024a8:    f5411180    A...    ADC      r1,r1,#0x100000
        0x100024ac:    0849        I.      LSRS     r1,r1,#1
        0x100024ae:    ea4f0030    O.0.    RRX      r0,r0
        0x100024b2:    1900        ..      ADDS     r0,r0,r4
        0x100024b4:    4151        QA      ADCS     r1,r1,r2
        0x100024b6:    4632        2F      MOV      r2,r6
        0x100024b8:    462b        +F      MOV      r3,r5
        0x100024ba:    b003        ..      ADD      sp,sp,#0xc
        0x100024bc:    e8bd4ff0    ...O    POP      {r4-r11,lr}
        0x100024c0:    f000b959    ..Y.    B.W      _double_round ; 0x10002776
        0x100024c4:    9800        ..      LDR      r0,[sp,#0]
        0x100024c6:    2201        ."      MOVS     r2,#1
        0x100024c8:    0040        @.      LSLS     r0,r0,#1
        0x100024ca:    2300        .#      MOVS     r3,#0
        0x100024cc:    ebd00202    ....    RSBS     r2,r0,r2
        0x100024d0:    eb6373e0    c..s    SBC      r3,r3,r0,ASR #31
        0x100024d4:    9800        ..      LDR      r0,[sp,#0]
        0x100024d6:    4621        !F      MOV      r1,r4
        0x100024d8:    ea4f74e0    O..t    ASR      r4,r0,#31
        0x100024dc:    ebb80000    ....    SUBS     r0,r8,r0
        0x100024e0:    eb610104    a...    SBC      r1,r1,r4
        0x100024e4:    e7e9        ..      B        0x100024ba ; __I$use$fp + 278
    __aeabi_dsub
        0x100024e6:    f0834300    ...C    EOR      r3,r3,#0x80000000
        0x100024ea:    e75b        [.      B        __I$use$fp ; 0x100023a4
    __aeabi_drsub
        0x100024ec:    f0814100    ...A    EOR      r1,r1,#0x80000000
        0x100024f0:    e758        X.      B        __I$use$fp ; 0x100023a4
    .text
    __aeabi_dmul
        0x100024f2:    e92d4ffe    -..O    PUSH     {r1-r11,lr}
        0x100024f6:    ea810403    ....    EOR      r4,r1,r3
        0x100024fa:    f0044400    ...D    AND      r4,r4,#0x80000000
        0x100024fe:    f0214100    !..A    BIC      r1,r1,#0x80000000
        0x10002502:    9400        ..      STR      r4,[sp,#0]
        0x10002504:    f04f0b00    O...    MOV      r11,#0
        0x10002508:    f0234300    #..C    BIC      r3,r3,#0x80000000
        0x1000250c:    ea500401    P...    ORRS     r4,r0,r1
        0x10002510:    d05e        ^.      BEQ      0x100025d0 ; __aeabi_dmul + 222
        0x10002512:    ea520403    R...    ORRS     r4,r2,r3
        0x10002516:    d05b        [.      BEQ      0x100025d0 ; __aeabi_dmul + 222
        0x10002518:    f3c3540a    ...T    UBFX     r4,r3,#20,#11
        0x1000251c:    f3c1550a    ...U    UBFX     r5,r1,#20,#11
        0x10002520:    442c        ,D      ADD      r4,r4,r5
        0x10002522:    f2a434f3    ...4    SUB      r4,r4,#0x3f3
        0x10002526:    9401        ..      STR      r4,[sp,#4]
        0x10002528:    fba05402    ...T    UMULL    r5,r4,r0,r2
        0x1000252c:    f3c10113    ....    UBFX     r1,r1,#0,#20
        0x10002530:    f4411180    A...    ORR      r1,r1,#0x100000
        0x10002534:    f3c30313    ....    UBFX     r3,r3,#0,#20
        0x10002538:    f4431380    C...    ORR      r3,r3,#0x100000
        0x1000253c:    fb014402    ...D    MLA      r4,r1,r2,r4
        0x10002540:    fb004e03    ...N    MLA      lr,r0,r3,r4
        0x10002544:    0a84        ..      LSRS     r4,r0,#10
        0x10002546:    0a97        ..      LSRS     r7,r2,#10
        0x10002548:    ea445481    D..T    ORR      r4,r4,r1,LSL #22
        0x1000254c:    ea475783    G..W    ORR      r7,r7,r3,LSL #22
        0x10002550:    fba46807    ...h    UMULL    r6,r8,r4,r7
        0x10002554:    9502        ..      STR      r5,[sp,#8]
        0x10002556:    0a8d        ..      LSRS     r5,r1,#10
        0x10002558:    fb058507    ....    MLA      r5,r5,r7,r8
        0x1000255c:    ea4f2c93    O..,    LSR      r12,r3,#10
        0x10002560:    fb04540c    ...T    MLA      r4,r4,r12,r5
        0x10002564:    0527        '.      LSLS     r7,r4,#20
        0x10002566:    9d02        ..      LDR      r5,[sp,#8]
        0x10002568:    ea4f5806    O..X    LSL      r8,r6,#20
        0x1000256c:    ea473716    G..7    ORR      r7,r7,r6,LSR #12
        0x10002570:    ebb50508    ....    SUBS     r5,r5,r8
        0x10002574:    eb6e0c07    n...    SBC      r12,lr,r7
        0x10002578:    0e87        ..      LSRS     r7,r0,#26
        0x1000257a:    0e92        ..      LSRS     r2,r2,#26
        0x1000257c:    ea471781    G...    ORR      r7,r7,r1,LSL #6
        0x10002580:    ea421283    B...    ORR      r2,r2,r3,LSL #6
        0x10002584:    fba70102    ....    UMULL    r0,r1,r7,r2
        0x10002588:    ebb6010b    ....    SUBS     r1,r6,r11
        0x1000258c:    eb640400    d...    SBC      r4,r4,r0
        0x10002590:    0d2b        +.      LSRS     r3,r5,#20
        0x10002592:    ea43330c    C..3    ORR      r3,r3,r12,LSL #12
        0x10002596:    185e        ^.      ADDS     r6,r3,r1
        0x10002598:    eb44501c    D..P    ADC      r0,r4,r12,LSR #20
        0x1000259c:    46da        .F      MOV      r10,r11
        0x1000259e:    4651        QF      MOV      r1,r10
        0x100025a0:    fbe70102    ....    UMLAL    r0,r1,r7,r2
        0x100025a4:    f3c50413    ....    UBFX     r4,r5,#0,#20
        0x100025a8:    ea4f330b    O..3    LSL      r3,r11,#12
        0x100025ac:    ea435314    C..S    ORR      r3,r3,r4,LSR #20
        0x100025b0:    ea4f3204    O..2    LSL      r2,r4,#12
        0x100025b4:    9c01        ..      LDR      r4,[sp,#4]
        0x100025b6:    ea430306    C...    ORR      r3,r3,r6
        0x100025ba:    f1a4040c    ....    SUB      r4,r4,#0xc
        0x100025be:    9402        ..      STR      r4,[sp,#8]
        0x100025c0:    9c00        ..      LDR      r4,[sp,#0]
        0x100025c2:    e9cdb400    ....    STRD     r11,r4,[sp,#0]
        0x100025c6:    f000f8e5    ....    BL       _double_epilogue ; 0x10002794
        0x100025ca:    b003        ..      ADD      sp,sp,#0xc
        0x100025cc:    e8bd8ff0    ....    POP      {r4-r11,pc}
        0x100025d0:    2000        .       MOVS     r0,#0
        0x100025d2:    4601        .F      MOV      r1,r0
        0x100025d4:    e7f9        ..      B        0x100025ca ; __aeabi_dmul + 216
    .text
    __aeabi_ddiv
        0x100025d6:    e92d4df0    -..M    PUSH     {r4-r8,r10,r11,lr}
        0x100025da:    ea810403    ....    EOR      r4,r1,r3
        0x100025de:    f0044b00    ...K    AND      r11,r4,#0x80000000
        0x100025e2:    f0214500    !..E    BIC      r5,r1,#0x80000000
        0x100025e6:    4614        .F      MOV      r4,r2
        0x100025e8:    f04f0a00    O...    MOV      r10,#0
        0x100025ec:    f0234100    #..A    BIC      r1,r3,#0x80000000
        0x100025f0:    ea500205    P...    ORRS     r2,r0,r5
        0x100025f4:    d020         .      BEQ      0x10002638 ; __aeabi_ddiv + 98
        0x100025f6:    ea540201    T...    ORRS     r2,r4,r1
        0x100025fa:    d01d        ..      BEQ      0x10002638 ; __aeabi_ddiv + 98
        0x100025fc:    f3c5570a    ...W    UBFX     r7,r5,#20,#11
        0x10002600:    4602        .F      MOV      r2,r0
        0x10002602:    f3c50313    ....    UBFX     r3,r5,#0,#20
        0x10002606:    f3c10013    ....    UBFX     r0,r1,#0,#20
        0x1000260a:    f3c1560a    ...V    UBFX     r6,r1,#20,#11
        0x1000260e:    f4401580    @...    ORR      r5,r0,#0x100000
        0x10002612:    f4431380    C...    ORR      r3,r3,#0x100000
        0x10002616:    eba70806    ....    SUB      r8,r7,r6
        0x1000261a:    1b10        ..      SUBS     r0,r2,r4
        0x1000261c:    46d6        .F      MOV      lr,r10
        0x1000261e:    f20838fd    ...8    ADD      r8,r8,#0x3fd
        0x10002622:    eb730005    s...    SBCS     r0,r3,r5
        0x10002626:    d302        ..      BCC      0x1000262e ; __aeabi_ddiv + 88
        0x10002628:    f1080801    ....    ADD      r8,r8,#1
        0x1000262c:    e001        ..      B        0x10002632 ; __aeabi_ddiv + 92
        0x1000262e:    1892        ..      ADDS     r2,r2,r2
        0x10002630:    415b        [A      ADCS     r3,r3,r3
        0x10002632:    f1b80f00    ....    CMP      r8,#0
        0x10002636:    da03        ..      BGE      0x10002640 ; __aeabi_ddiv + 106
        0x10002638:    2000        .       MOVS     r0,#0
        0x1000263a:    4601        .F      MOV      r1,r0
        0x1000263c:    e8bd8df0    ....    POP      {r4-r8,r10,r11,pc}
        0x10002640:    2000        .       MOVS     r0,#0
        0x10002642:    f44f1180    O...    MOV      r1,#0x100000
        0x10002646:    4606        .F      MOV      r6,r0
        0x10002648:    4684        .F      MOV      r12,r0
        0x1000264a:    e00e        ..      B        0x1000266a ; __aeabi_ddiv + 148
        0x1000264c:    1b17        ..      SUBS     r7,r2,r4
        0x1000264e:    eb730705    s...    SBCS     r7,r3,r5
        0x10002652:    d305        ..      BCC      0x10002660 ; __aeabi_ddiv + 138
        0x10002654:    1b12        ..      SUBS     r2,r2,r4
        0x10002656:    eb630305    c...    SBC      r3,r3,r5
        0x1000265a:    4306        .C      ORRS     r6,r6,r0
        0x1000265c:    ea4c0c01    L...    ORR      r12,r12,r1
        0x10002660:    0849        I.      LSRS     r1,r1,#1
        0x10002662:    ea4f0030    O.0.    RRX      r0,r0
        0x10002666:    1892        ..      ADDS     r2,r2,r2
        0x10002668:    415b        [A      ADCS     r3,r3,r3
        0x1000266a:    ea500701    P...    ORRS     r7,r0,r1
        0x1000266e:    d1ed        ..      BNE      0x1000264c ; __aeabi_ddiv + 118
        0x10002670:    ea520003    R...    ORRS     r0,r2,r3
        0x10002674:    d012        ..      BEQ      0x1000269c ; __aeabi_ddiv + 198
        0x10002676:    ea820004    ....    EOR      r0,r2,r4
        0x1000267a:    ea830105    ....    EOR      r1,r3,r5
        0x1000267e:    4308        .C      ORRS     r0,r0,r1
        0x10002680:    d005        ..      BEQ      0x1000268e ; __aeabi_ddiv + 184
        0x10002682:    1b10        ..      SUBS     r0,r2,r4
        0x10002684:    41ab        .A      SBCS     r3,r3,r5
        0x10002686:    d206        ..      BCS      0x10002696 ; __aeabi_ddiv + 192
        0x10002688:    2201        ."      MOVS     r2,#1
        0x1000268a:    2300        .#      MOVS     r3,#0
        0x1000268c:    e006        ..      B        0x1000269c ; __aeabi_ddiv + 198
        0x1000268e:    2200        ."      MOVS     r2,#0
        0x10002690:    f04f4300    O..C    MOV      r3,#0x80000000
        0x10002694:    e002        ..      B        0x1000269c ; __aeabi_ddiv + 198
        0x10002696:    f06f0201    o...    MVN      r2,#1
        0x1000269a:    1053        S.      ASRS     r3,r2,#1
        0x1000269c:    eb1a0006    ....    ADDS     r0,r10,r6
        0x100026a0:    eb4c5108    L..Q    ADC      r1,r12,r8,LSL #20
        0x100026a4:    eb10000a    ....    ADDS     r0,r0,r10
        0x100026a8:    eb41010b    A...    ADC      r1,r1,r11
        0x100026ac:    e8bd4df0    ...M    POP      {r4-r8,r10,r11,lr}
        0x100026b0:    f000b861    ..a.    B.W      _double_round ; 0x10002776
    .text
    __aeabi_d2ulz
        0x100026b4:    f3c1520a    ...R    UBFX     r2,r1,#20,#11
        0x100026b8:    f3c10113    ....    UBFX     r1,r1,#0,#20
        0x100026bc:    f24033ff    @..3    MOV      r3,#0x3ff
        0x100026c0:    f4411180    A...    ORR      r1,r1,#0x100000
        0x100026c4:    429a        .B      CMP      r2,r3
        0x100026c6:    da02        ..      BGE      0x100026ce ; __aeabi_d2ulz + 26
        0x100026c8:    2000        .       MOVS     r0,#0
        0x100026ca:    4601        .F      MOV      r1,r0
        0x100026cc:    4770        pG      BX       lr
        0x100026ce:    f2404333    @.3C    MOV      r3,#0x433
        0x100026d2:    429a        .B      CMP      r2,r3
        0x100026d4:    f2a24233    ..3B    SUB      r2,r2,#0x433
        0x100026d8:    dc02        ..      BGT      0x100026e0 ; __aeabi_d2ulz + 44
        0x100026da:    4252        RB      RSBS     r2,r2,#0
        0x100026dc:    f000b829    ..).    B.W      __aeabi_llsr ; 0x10002732
        0x100026e0:    f000b818    ....    B.W      __aeabi_llsl ; 0x10002714
    .text
    __aeabi_cdrcmple
        0x100026e4:    b530        0.      PUSH     {r4,r5,lr}
        0x100026e6:    1e04        ..      SUBS     r4,r0,#0
        0x100026e8:    f1710400    q...    SBCS     r4,r1,#0
        0x100026ec:    db04        ..      BLT      0x100026f8 ; __aeabi_cdrcmple + 20
        0x100026ee:    f04f4400    O..D    MOV      r4,#0x80000000
        0x100026f2:    4240        @B      RSBS     r0,r0,#0
        0x100026f4:    eb640101    d...    SBC      r1,r4,r1
        0x100026f8:    1e14        ..      SUBS     r4,r2,#0
        0x100026fa:    f1730400    s...    SBCS     r4,r3,#0
        0x100026fe:    db05        ..      BLT      0x1000270c ; __aeabi_cdrcmple + 40
        0x10002700:    461c        .F      MOV      r4,r3
        0x10002702:    f04f4300    O..C    MOV      r3,#0x80000000
        0x10002706:    4252        RB      RSBS     r2,r2,#0
        0x10002708:    eb630304    c...    SBC      r3,r3,r4
        0x1000270c:    4299        .B      CMP      r1,r3
        0x1000270e:    bf08        ..      IT       EQ
        0x10002710:    4290        .B      CMPEQ    r0,r2
        0x10002712:    bd30        0.      POP      {r4,r5,pc}
    .text
    __aeabi_llsl
    _ll_shift_l
        0x10002714:    2a20         *      CMP      r2,#0x20
        0x10002716:    db04        ..      BLT      0x10002722 ; __aeabi_llsl + 14
        0x10002718:    3a20         :      SUBS     r2,r2,#0x20
        0x1000271a:    fa00f102    ....    LSL      r1,r0,r2
        0x1000271e:    2000        .       MOVS     r0,#0
        0x10002720:    4770        pG      BX       lr
        0x10002722:    4091        .@      LSLS     r1,r1,r2
        0x10002724:    f1c20320    .. .    RSB      r3,r2,#0x20
        0x10002728:    fa20f303     ...    LSR      r3,r0,r3
        0x1000272c:    4319        .C      ORRS     r1,r1,r3
        0x1000272e:    4090        .@      LSLS     r0,r0,r2
        0x10002730:    4770        pG      BX       lr
    .text
    __aeabi_llsr
    _ll_ushift_r
        0x10002732:    2a20         *      CMP      r2,#0x20
        0x10002734:    db04        ..      BLT      0x10002740 ; __aeabi_llsr + 14
        0x10002736:    3a20         :      SUBS     r2,r2,#0x20
        0x10002738:    fa21f002    !...    LSR      r0,r1,r2
        0x1000273c:    2100        .!      MOVS     r1,#0
        0x1000273e:    4770        pG      BX       lr
        0x10002740:    fa21f302    !...    LSR      r3,r1,r2
        0x10002744:    40d0        .@      LSRS     r0,r0,r2
        0x10002746:    f1c20220    .. .    RSB      r2,r2,#0x20
        0x1000274a:    4091        .@      LSLS     r1,r1,r2
        0x1000274c:    4308        .C      ORRS     r0,r0,r1
        0x1000274e:    4619        .F      MOV      r1,r3
        0x10002750:    4770        pG      BX       lr
    .text
    __aeabi_lasr
    _ll_sshift_r
        0x10002752:    2a20         *      CMP      r2,#0x20
        0x10002754:    db06        ..      BLT      0x10002764 ; __aeabi_lasr + 18
        0x10002756:    17cb        ..      ASRS     r3,r1,#31
        0x10002758:    3a20         :      SUBS     r2,r2,#0x20
        0x1000275a:    fa41f002    A...    ASR      r0,r1,r2
        0x1000275e:    ea4373e0    C..s    ORR      r3,r3,r0,ASR #31
        0x10002762:    e006        ..      B        0x10002772 ; __aeabi_lasr + 32
        0x10002764:    fa41f302    A...    ASR      r3,r1,r2
        0x10002768:    40d0        .@      LSRS     r0,r0,r2
        0x1000276a:    f1c20220    .. .    RSB      r2,r2,#0x20
        0x1000276e:    4091        .@      LSLS     r1,r1,r2
        0x10002770:    4308        .C      ORRS     r0,r0,r1
        0x10002772:    4619        .F      MOV      r1,r3
        0x10002774:    4770        pG      BX       lr
    .text
    _double_round
        0x10002776:    b510        ..      PUSH     {r4,lr}
        0x10002778:    1e14        ..      SUBS     r4,r2,#0
        0x1000277a:    f1730400    s...    SBCS     r4,r3,#0
        0x1000277e:    da08        ..      BGE      0x10002792 ; _double_round + 28
        0x10002780:    1c40        @.      ADDS     r0,r0,#1
        0x10002782:    f1410100    A...    ADC      r1,r1,#0
        0x10002786:    1892        ..      ADDS     r2,r2,r2
        0x10002788:    415b        [A      ADCS     r3,r3,r3
        0x1000278a:    431a        .C      ORRS     r2,r2,r3
        0x1000278c:    d101        ..      BNE      0x10002792 ; _double_round + 28
        0x1000278e:    f0200001     ...    BIC      r0,r0,#1
        0x10002792:    bd10        ..      POP      {r4,pc}
    _double_epilogue
        0x10002794:    e92d4df0    -..M    PUSH     {r4-r8,r10,r11,lr}
        0x10002798:    4692        .F      MOV      r10,r2
        0x1000279a:    469b        .F      MOV      r11,r3
        0x1000279c:    b111        ..      CBZ      r1,0x100027a4 ; _double_epilogue + 16
        0x1000279e:    fab1f281    ....    CLZ      r2,r1
        0x100027a2:    e002        ..      B        0x100027aa ; _double_epilogue + 22
        0x100027a4:    fab0f280    ....    CLZ      r2,r0
        0x100027a8:    3220         2      ADDS     r2,r2,#0x20
        0x100027aa:    4690        .F      MOV      r8,r2
        0x100027ac:    f7ffffb2    ....    BL       __aeabi_llsl ; 0x10002714
        0x100027b0:    4604        .F      MOV      r4,r0
        0x100027b2:    460f        .F      MOV      r7,r1
        0x100027b4:    ea40000a    @...    ORR      r0,r0,r10
        0x100027b8:    ea41010b    A...    ORR      r1,r1,r11
        0x100027bc:    4653        SF      MOV      r3,r10
        0x100027be:    465a        ZF      MOV      r2,r11
        0x100027c0:    4308        .C      ORRS     r0,r0,r1
        0x100027c2:    d013        ..      BEQ      0x100027ec ; _double_epilogue + 88
        0x100027c4:    4611        .F      MOV      r1,r2
        0x100027c6:    ea530001    S...    ORRS     r0,r3,r1
        0x100027ca:    d019        ..      BEQ      0x10002800 ; _double_epilogue + 108
        0x100027cc:    f1c80240    ..@.    RSB      r2,r8,#0x40
        0x100027d0:    4650        PF      MOV      r0,r10
        0x100027d2:    f7ffffae    ....    BL       __aeabi_llsr ; 0x10002732
        0x100027d6:    4605        .F      MOV      r5,r0
        0x100027d8:    460e        .F      MOV      r6,r1
        0x100027da:    4650        PF      MOV      r0,r10
        0x100027dc:    4659        YF      MOV      r1,r11
        0x100027de:    4642        BF      MOV      r2,r8
        0x100027e0:    f7ffff98    ....    BL       __aeabi_llsl ; 0x10002714
        0x100027e4:    4308        .C      ORRS     r0,r0,r1
        0x100027e6:    d005        ..      BEQ      0x100027f4 ; _double_epilogue + 96
        0x100027e8:    2001        .       MOVS     r0,#1
        0x100027ea:    e004        ..      B        0x100027f6 ; _double_epilogue + 98
        0x100027ec:    4620         F      MOV      r0,r4
        0x100027ee:    4639        9F      MOV      r1,r7
        0x100027f0:    e8bd8df0    ....    POP      {r4-r8,r10,r11,pc}
        0x100027f4:    2000        .       MOVS     r0,#0
        0x100027f6:    4305        .C      ORRS     r5,r5,r0
        0x100027f8:    ea4676e0    F..v    ORR      r6,r6,r0,ASR #31
        0x100027fc:    432c        ,C      ORRS     r4,r4,r5
        0x100027fe:    4337        7C      ORRS     r7,r7,r6
        0x10002800:    980a        ..      LDR      r0,[sp,#0x28]
        0x10002802:    0563        c.      LSLS     r3,r4,#21
        0x10002804:    0ae4        ..      LSRS     r4,r4,#11
        0x10002806:    eba00008    ....    SUB      r0,r0,r8
        0x1000280a:    2200        ."      MOVS     r2,#0
        0x1000280c:    0afd        ..      LSRS     r5,r7,#11
        0x1000280e:    ea445447    D.GT    ORR      r4,r4,r7,LSL #21
        0x10002812:    300a        .0      ADDS     r0,r0,#0xa
        0x10002814:    d502        ..      BPL      0x1000281c ; _double_epilogue + 136
        0x10002816:    2000        .       MOVS     r0,#0
        0x10002818:    4601        .F      MOV      r1,r0
        0x1000281a:    e7e9        ..      B        0x100027f0 ; _double_epilogue + 92
        0x1000281c:    0501        ..      LSLS     r1,r0,#20
        0x1000281e:    1910        ..      ADDS     r0,r2,r4
        0x10002820:    4169        iA      ADCS     r1,r1,r5
        0x10002822:    e9dd4508    ...E    LDRD     r4,r5,[sp,#0x20]
        0x10002826:    1900        ..      ADDS     r0,r0,r4
        0x10002828:    4169        iA      ADCS     r1,r1,r5
        0x1000282a:    e8bd4df0    ...M    POP      {r4-r8,r10,r11,lr}
        0x1000282e:    e7a2        ..      B        _double_round ; 0x10002776
    HS300X_ClearDataReady
        0x10002830:    f24b0030    K.0.    MOV      r0,#0xb030
        0x10002834:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002838:    2100        .!      MOVS     r1,#0
        0x1000283a:    7001        .p      STRB     r1,[r0,#0]
        0x1000283c:    4770        pG      BX       lr
        0x1000283e:    0000        ..      MOVS     r0,r0
    HS300X_DataReady
        0x10002840:    f24b0030    K.0.    MOV      r0,#0xb030
        0x10002844:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002848:    7800        .x      LDRB     r0,[r0,#0]
        0x1000284a:    4770        pG      BX       lr
    HS300X_Init
        0x1000284c:    f24b0008    K...    MOV      r0,#0xb008
        0x10002850:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002854:    2100        .!      MOVS     r1,#0
        0x10002856:    6001        .`      STR      r1,[r0,#0]
        0x10002858:    f24b000c    K...    MOV      r0,#0xb00c
        0x1000285c:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002860:    6001        .`      STR      r1,[r0,#0]
        0x10002862:    f24b005e    K.^.    MOV      r0,#0xb05e
        0x10002866:    f2c20000    ....    MOVT     r0,#0x2000
        0x1000286a:    7001        .p      STRB     r1,[r0,#0]
        0x1000286c:    f24b0038    K.8.    MOV      r0,#0xb038
        0x10002870:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002874:    7001        .p      STRB     r1,[r0,#0]
        0x10002876:    f24b0030    K.0.    MOV      r0,#0xb030
        0x1000287a:    f2c20000    ....    MOVT     r0,#0x2000
        0x1000287e:    7001        .p      STRB     r1,[r0,#0]
        0x10002880:    f24b002c    K.,.    MOV      r0,#0xb02c
        0x10002884:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002888:    6001        .`      STR      r1,[r0,#0]
        0x1000288a:    4770        pG      BX       lr
    HS300X_IsBusy
        0x1000288c:    f24b005e    K.^.    MOV      r0,#0xb05e
        0x10002890:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002894:    7800        .x      LDRB     r0,[r0,#0]
        0x10002896:    2800        .(      CMP      r0,#0
        0x10002898:    bf18        ..      IT       NE
        0x1000289a:    2001        .       MOVNE    r0,#1
        0x1000289c:    4770        pG      BX       lr
        0x1000289e:    0000        ..      MOVS     r0,r0
    HS300X_Process
        0x100028a0:    b510        ..      PUSH     {r4,lr}
        0x100028a2:    f000fdb1    ....    BL       I2C_HAL_TakeEvent ; 0x10003408
        0x100028a6:    2803        .(      CMP      r0,#3
        0x100028a8:    d111        ..      BNE      0x100028ce ; HS300X_Process + 46
        0x100028aa:    f24b005e    K.^.    MOV      r0,#0xb05e
        0x100028ae:    f2c20000    ....    MOVT     r0,#0x2000
        0x100028b2:    2100        .!      MOVS     r1,#0
        0x100028b4:    7001        .p      STRB     r1,[r0,#0]
        0x100028b6:    f24b0038    K.8.    MOV      r0,#0xb038
        0x100028ba:    f2c20000    ....    MOVT     r0,#0x2000
        0x100028be:    2203        ."      MOVS     r2,#3
        0x100028c0:    7002        .p      STRB     r2,[r0,#0]
        0x100028c2:    f24b0030    K.0.    MOV      r0,#0xb030
        0x100028c6:    f2c20000    ....    MOVT     r0,#0x2000
        0x100028ca:    7001        .p      STRB     r1,[r0,#0]
        0x100028cc:    bd10        ..      POP      {r4,pc}
        0x100028ce:    f24b045e    K.^.    MOV      r4,#0xb05e
        0x100028d2:    f2c20400    ....    MOVT     r4,#0x2000
        0x100028d6:    7821        !x      LDRB     r1,[r4,#0]
        0x100028d8:    2903        .)      CMP      r1,#3
        0x100028da:    d023        #.      BEQ      0x10002924 ; HS300X_Process + 132
        0x100028dc:    2902        .)      CMP      r1,#2
        0x100028de:    d004        ..      BEQ      0x100028ea ; HS300X_Process + 74
        0x100028e0:    2901        .)      CMP      r1,#1
        0x100028e2:    bf08        ..      IT       EQ
        0x100028e4:    2801        .(      CMPEQ    r0,#1
        0x100028e6:    d06a        j.      BEQ      0x100029be ; HS300X_Process + 286
        0x100028e8:    bd10        ..      POP      {r4,pc}
        0x100028ea:    f000fa45    ..E.    BL       I2C_HAL_GetTickMs ; 0x10002d78
        0x100028ee:    f24b012c    K.,.    MOV      r1,#0xb02c
        0x100028f2:    f2c20100    ....    MOVT     r1,#0x2000
        0x100028f6:    6809        .h      LDR      r1,[r1,#0]
        0x100028f8:    1a40        @.      SUBS     r0,r0,r1
        0x100028fa:    2828        ((      CMP      r0,#0x28
        0x100028fc:    d3f4        ..      BCC      0x100028e8 ; HS300X_Process + 72
        0x100028fe:    f24b0040    K.@.    MOV      r0,#0xb040
        0x10002902:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002906:    2104        .!      MOVS     r1,#4
        0x10002908:    2201        ."      MOVS     r2,#1
        0x1000290a:    f000fb6d    ..m.    BL       I2C_HAL_MasterReadDMA ; 0x10002fe8
        0x1000290e:    2800        .(      CMP      r0,#0
        0x10002910:    d05f        _.      BEQ      0x100029d2 ; HS300X_Process + 306
        0x10002912:    2000        .       MOVS     r0,#0
        0x10002914:    7020         p      STRB     r0,[r4,#0]
        0x10002916:    f24b0038    K.8.    MOV      r0,#0xb038
        0x1000291a:    f2c20000    ....    MOVT     r0,#0x2000
        0x1000291e:    2103        .!      MOVS     r1,#3
        0x10002920:    7001        .p      STRB     r1,[r0,#0]
        0x10002922:    bd10        ..      POP      {r4,pc}
        0x10002924:    2802        .(      CMP      r0,#2
        0x10002926:    bf18        ..      IT       NE
        0x10002928:    bd10        ..      POPNE    {r4,pc}
        0x1000292a:    f24b0140    K.@.    MOV      r1,#0xb040
        0x1000292e:    f2c20100    ....    MOVT     r1,#0x2000
        0x10002932:    780a        .x      LDRB     r2,[r1,#0]
        0x10002934:    f00200c0    ....    AND      r0,r2,#0xc0
        0x10002938:    2840        @(      CMP      r0,#0x40
        0x1000293a:    d02f        /.      BEQ      0x1000299c ; HS300X_Process + 252
        0x1000293c:    784b        Kx      LDRB     r3,[r1,#1]
        0x1000293e:    8849        I.      LDRH     r1,[r1,#2]
        0x10002940:    f002023f    ..?.    AND      r2,r2,#0x3f
        0x10002944:    ea432202    C.."    ORR      r2,r3,r2,LSL #8
        0x10002948:    ba09        ..      REV      r1,r1
        0x1000294a:    0c89        ..      LSRS     r1,r1,#18
        0x1000294c:    ee002a10    ...*    VMOV     s0,r2
        0x10002950:    ee021a10    ....    VMOV     s4,r1
        0x10002954:    eeb80a40    ..@.    VCVT.F32.U32 s0,s0
        0x10002958:    ed9f1a1f    ....    VLDR     s2,[pc,#124] ; [0x100029d8] = 0x467ffc00
        0x1000295c:    eeb82a42    ..B*    VCVT.F32.U32 s4,s4
        0x10002960:    ee800a01    ....    VDIV.F32 s0,s0,s2
        0x10002964:    ee821a01    ....    VDIV.F32 s2,s4,s2
        0x10002968:    ed9f2a1c    ...*    VLDR     s4,[pc,#112] ; [0x100029dc] = 0x42c80000
        0x1000296c:    ed9f3a1c    ...:    VLDR     s6,[pc,#112] ; [0x100029e0] = 0x43250000
        0x10002970:    f24b0108    K...    MOV      r1,#0xb008
        0x10002974:    f2c20100    ....    MOVT     r1,#0x2000
        0x10002978:    ee200a02     ...    VMUL.F32 s0,s0,s4
        0x1000297c:    ee211a03    !...    VMUL.F32 s2,s2,s6
        0x10002980:    ed9f2a18    ...*    VLDR     s4,[pc,#96] ; [0x100029e4] = 0xc2200000
        0x10002984:    ed810a00    ....    VSTR     s0,[r1,#0]
        0x10002988:    f24b010c    K...    MOV      r1,#0xb00c
        0x1000298c:    ee311a02    1...    VADD.F32 s2,s2,s4
        0x10002990:    f2c20100    ....    MOVT     r1,#0x2000
        0x10002994:    ed811a00    ....    VSTR     s2,[r1,#0]
        0x10002998:    2100        .!      MOVS     r1,#0
        0x1000299a:    e000        ..      B        0x1000299e ; HS300X_Process + 254
        0x1000299c:    2104        .!      MOVS     r1,#4
        0x1000299e:    f24b0238    K.8.    MOV      r2,#0xb038
        0x100029a2:    3840        @8      SUBS     r0,r0,#0x40
        0x100029a4:    f2c20200    ....    MOVT     r2,#0x2000
        0x100029a8:    bf18        ..      IT       NE
        0x100029aa:    2001        .       MOVNE    r0,#1
        0x100029ac:    7011        .p      STRB     r1,[r2,#0]
        0x100029ae:    f24b0130    K.0.    MOV      r1,#0xb030
        0x100029b2:    f2c20100    ....    MOVT     r1,#0x2000
        0x100029b6:    7008        .p      STRB     r0,[r1,#0]
        0x100029b8:    2000        .       MOVS     r0,#0
        0x100029ba:    7020         p      STRB     r0,[r4,#0]
        0x100029bc:    bd10        ..      POP      {r4,pc}
        0x100029be:    f000f9db    ....    BL       I2C_HAL_GetTickMs ; 0x10002d78
        0x100029c2:    f24b012c    K.,.    MOV      r1,#0xb02c
        0x100029c6:    f2c20100    ....    MOVT     r1,#0x2000
        0x100029ca:    6008        .`      STR      r0,[r1,#0]
        0x100029cc:    2002        .       MOVS     r0,#2
        0x100029ce:    7020         p      STRB     r0,[r4,#0]
        0x100029d0:    bd10        ..      POP      {r4,pc}
        0x100029d2:    2003        .       MOVS     r0,#3
        0x100029d4:    7020         p      STRB     r0,[r4,#0]
        0x100029d6:    bd10        ..      POP      {r4,pc}
    $d
        0x100029d8:    467ffc00    ...F    DCD    1182792704
        0x100029dc:    42c80000    ...B    DCD    1120403456
        0x100029e0:    43250000    ..%C    DCD    1126498304
        0x100029e4:    c2200000    .. .    DCD    3256877056
    $t
    HS300X_StartMeasurement
        0x100029e8:    b570        p.      PUSH     {r4-r6,lr}
        0x100029ea:    f24b045e    K.^.    MOV      r4,#0xb05e
        0x100029ee:    f2c20400    ....    MOVT     r4,#0x2000
        0x100029f2:    7820         x      LDRB     r0,[r4,#0]
        0x100029f4:    b910        ..      CBNZ     r0,0x100029fc ; HS300X_StartMeasurement + 20
        0x100029f6:    f000f9c5    ....    BL       I2C_HAL_IsBusy ; 0x10002d84
        0x100029fa:    b108        ..      CBZ      r0,0x10002a00 ; HS300X_StartMeasurement + 24
        0x100029fc:    2001        .       MOVS     r0,#1
        0x100029fe:    bd70        p.      POP      {r4-r6,pc}
        0x10002a00:    f24b0030    K.0.    MOV      r0,#0xb030
        0x10002a04:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002a08:    2100        .!      MOVS     r1,#0
        0x10002a0a:    f24b0538    K.8.    MOV      r5,#0xb038
        0x10002a0e:    7001        .p      STRB     r1,[r0,#0]
        0x10002a10:    f2c20500    ....    MOVT     r5,#0x2000
        0x10002a14:    f24b0004    K...    MOV      r0,#0xb004
        0x10002a18:    7029        )p      STRB     r1,[r5,#0]
        0x10002a1a:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002a1e:    2188        .!      MOVS     r1,#0x88
        0x10002a20:    7001        .p      STRB     r1,[r0,#0]
        0x10002a22:    2101        .!      MOVS     r1,#1
        0x10002a24:    2201        ."      MOVS     r2,#1
        0x10002a26:    2601        .&      MOVS     r6,#1
        0x10002a28:    f000fb58    ..X.    BL       I2C_HAL_MasterWriteDMA ; 0x100030dc
        0x10002a2c:    2800        .(      CMP      r0,#0
        0x10002a2e:    bf19        ..      ITTEE    NE
        0x10002a30:    2003        .       MOVNE    r0,#3
        0x10002a32:    7028        (p      STRBNE   r0,[r5,#0]
        0x10002a34:    7026        &p      STRBEQ   r6,[r4,#0]
        0x10002a36:    2000        .       MOVEQ    r0,#0
        0x10002a38:    bd70        p.      POP      {r4-r6,pc}
        0x10002a3a:    0000        ..      MOVS     r0,r0
    HardFault_Handler_Proc
        0x10002a3c:    b082        ..      SUB      sp,sp,#8
        0x10002a3e:    f64e5728    N.(W    MOV      r7,#0xed28
        0x10002a42:    4615        .F      MOV      r5,r2
        0x10002a44:    460c        .F      MOV      r4,r1
        0x10002a46:    4606        .F      MOV      r6,r0
        0x10002a48:    f2ce0700    ....    MOVT     r7,#0xe000
        0x10002a4c:    f000fd7e    ..~.    BL       app_debug_reinit ; 0x1000354c
        0x10002a50:    f24440c0    D..@    MOV      r0,#0x44c0
        0x10002a54:    f3ef8108    ....    MRS      r1,MSP
        0x10002a58:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002a5c:    f001f81e    ....    BL       __0printf ; 0x10003a9c
        0x10002a60:    0730        0.      LSLS     r0,r6,#28
        0x10002a62:    f6441005    D...    MOV      r0,#0x4905
        0x10002a66:    f6441124    D.$.    MOV      r1,#0x4924
        0x10002a6a:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002a6e:    f2c10100    ....    MOVT     r1,#0x1000
        0x10002a72:    bf58        X.      IT       PL
        0x10002a74:    4608        .F      MOVPL    r0,r1
        0x10002a76:    f001fc7b    ..{.    BL       puts ; 0x10004370
        0x10002a7a:    f0160004    ....    ANDS     r0,r6,#4
        0x10002a7e:    f6441116    D...    MOV      r1,#0x4916
        0x10002a82:    a092        ..      ADR      r0,{pc}+0x24a ; 0x10002ccc
        0x10002a84:    f2c10100    ....    MOVT     r1,#0x1000
        0x10002a88:    bf0c        ..      ITE      EQ
        0x10002a8a:    4608        .F      MOVEQ    r0,r1
        0x10002a8c:    462c        ,F      MOVNE    r4,r5
        0x10002a8e:    f001fc6f    ..o.    BL       puts ; 0x10004370
        0x10002a92:    a092        ..      ADR      r0,{pc}+0x24a ; 0x10002cdc
        0x10002a94:    f001fc6c    ..l.    BL       puts ; 0x10004370
        0x10002a98:    6821        !h      LDR      r1,[r4,#0]
        0x10002a9a:    a094        ..      ADR      r0,{pc}+0x252 ; 0x10002cec
        0x10002a9c:    f000fffe    ....    BL       __0printf ; 0x10003a9c
        0x10002aa0:    6861        ah      LDR      r1,[r4,#4]
        0x10002aa2:    a096        ..      ADR      r0,{pc}+0x25a ; 0x10002cfc
        0x10002aa4:    f000fffa    ....    BL       __0printf ; 0x10003a9c
        0x10002aa8:    68a1        .h      LDR      r1,[r4,#8]
        0x10002aaa:    a098        ..      ADR      r0,{pc}+0x262 ; 0x10002d0c
        0x10002aac:    f000fff6    ....    BL       __0printf ; 0x10003a9c
        0x10002ab0:    68e1        .h      LDR      r1,[r4,#0xc]
        0x10002ab2:    a09a        ..      ADR      r0,{pc}+0x26a ; 0x10002d1c
        0x10002ab4:    f000fff2    ....    BL       __0printf ; 0x10003a9c
        0x10002ab8:    6921        !i      LDR      r1,[r4,#0x10]
        0x10002aba:    a09c        ..      ADR      r0,{pc}+0x272 ; 0x10002d2c
        0x10002abc:    f000ffee    ....    BL       __0printf ; 0x10003a9c
        0x10002ac0:    6961        ai      LDR      r1,[r4,#0x14]
        0x10002ac2:    a09e        ..      ADR      r0,{pc}+0x27a ; 0x10002d3c
        0x10002ac4:    f000ffea    ....    BL       __0printf ; 0x10003a9c
        0x10002ac8:    69a1        .i      LDR      r1,[r4,#0x18]
        0x10002aca:    a0a0        ..      ADR      r0,{pc}+0x282 ; 0x10002d4c
        0x10002acc:    f000ffe6    ....    BL       __0printf ; 0x10003a9c
        0x10002ad0:    69e1        .i      LDR      r1,[r4,#0x1c]
        0x10002ad2:    a0a2        ..      ADR      r0,{pc}+0x28a ; 0x10002d5c
        0x10002ad4:    f000ffe2    ....    BL       __0printf ; 0x10003a9c
        0x10002ad8:    69a0        .i      LDR      r0,[r4,#0x18]
        0x10002ada:    9001        ..      STR      r0,[sp,#4]
        0x10002adc:    6878        xh      LDR      r0,[r7,#4]
        0x10002ade:    0780        ..      LSLS     r0,r0,#30
        0x10002ae0:    d505        ..      BPL      0x10002aee ; HardFault_Handler_Proc + 178
        0x10002ae2:    f64400d9    D...    MOV      r0,#0x48d9
        0x10002ae6:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002aea:    f001fc41    ..A.    BL       puts ; 0x10004370
        0x10002aee:    6878        xh      LDR      r0,[r7,#4]
        0x10002af0:    f1b03fff    ...?    CMP      r0,#0xffffffff
        0x10002af4:    dc05        ..      BGT      0x10002b02 ; HardFault_Handler_Proc + 198
        0x10002af6:    f64400f2    D...    MOV      r0,#0x48f2
        0x10002afa:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002afe:    f001fc37    ..7.    BL       puts ; 0x10004370
        0x10002b02:    6878        xh      LDR      r0,[r7,#4]
        0x10002b04:    0040        @.      LSLS     r0,r0,#1
        0x10002b06:    f14080dc    @...    BPL.W    0x10002cc2 ; HardFault_Handler_Proc + 646
        0x10002b0a:    f64400c5    D...    MOV      r0,#0x48c5
        0x10002b0e:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002b12:    f001fc2d    ..-.    BL       puts ; 0x10004370
        0x10002b16:    6838        8h      LDR      r0,[r7,#0]
        0x10002b18:    0600        ..      LSLS     r0,r0,#24
        0x10002b1a:    d03e        >.      BEQ      0x10002b9a ; HardFault_Handler_Proc + 350
        0x10002b1c:    f64400a7    D...    MOV      r0,#0x48a7
        0x10002b20:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002b24:    f001fc24    ..$.    BL       puts ; 0x10004370
        0x10002b28:    6838        8h      LDR      r0,[r7,#0]
        0x10002b2a:    07c0        ..      LSLS     r0,r0,#31
        0x10002b2c:    d006        ..      BEQ      0x10002b3c ; HardFault_Handler_Proc + 256
        0x10002b2e:    9901        ..      LDR      r1,[sp,#4]
        0x10002b30:    f244403e    D.>@    MOV      r0,#0x443e
        0x10002b34:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002b38:    f000ffb0    ....    BL       __0printf ; 0x10003a9c
        0x10002b3c:    6838        8h      LDR      r0,[r7,#0]
        0x10002b3e:    0780        ..      LSLS     r0,r0,#30
        0x10002b40:    d510        ..      BPL      0x10002b64 ; HardFault_Handler_Proc + 296
        0x10002b42:    9901        ..      LDR      r1,[sp,#4]
        0x10002b44:    f24430cb    D..0    MOV      r0,#0x43cb
        0x10002b48:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002b4c:    f000ffa6    ....    BL       __0printf ; 0x10003a9c
        0x10002b50:    6838        8h      LDR      r0,[r7,#0]
        0x10002b52:    0600        ..      LSLS     r0,r0,#24
        0x10002b54:    d506        ..      BPL      0x10002b64 ; HardFault_Handler_Proc + 296
        0x10002b56:    68f9        .h      LDR      r1,[r7,#0xc]
        0x10002b58:    f24440b3    D..@    MOV      r0,#0x44b3
        0x10002b5c:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002b60:    f000ff9c    ....    BL       __0printf ; 0x10003a9c
        0x10002b64:    6838        8h      LDR      r0,[r7,#0]
        0x10002b66:    0700        ..      LSLS     r0,r0,#28
        0x10002b68:    d505        ..      BPL      0x10002b76 ; HardFault_Handler_Proc + 314
        0x10002b6a:    f2447069    D.ip    MOV      r0,#0x4769
        0x10002b6e:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002b72:    f001fbfd    ....    BL       puts ; 0x10004370
        0x10002b76:    6838        8h      LDR      r0,[r7,#0]
        0x10002b78:    06c0        ..      LSLS     r0,r0,#27
        0x10002b7a:    d505        ..      BPL      0x10002b88 ; HardFault_Handler_Proc + 332
        0x10002b7c:    f24470be    D..p    MOV      r0,#0x47be
        0x10002b80:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002b84:    f001fbf4    ....    BL       puts ; 0x10004370
        0x10002b88:    6838        8h      LDR      r0,[r7,#0]
        0x10002b8a:    0680        ..      LSLS     r0,r0,#26
        0x10002b8c:    d505        ..      BPL      0x10002b9a ; HardFault_Handler_Proc + 350
        0x10002b8e:    f24460ca    D..`    MOV      r0,#0x46ca
        0x10002b92:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002b96:    f001fbeb    ....    BL       puts ; 0x10004370
        0x10002b9a:    6838        8h      LDR      r0,[r7,#0]
        0x10002b9c:    f4104f7f    ...O    TST      r0,#0xff00
        0x10002ba0:    d046        F.      BEQ      0x10002c30 ; HardFault_Handler_Proc + 500
        0x10002ba2:    f64400e7    D...    MOV      r0,#0x48e7
        0x10002ba6:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002baa:    f001fbe1    ....    BL       puts ; 0x10004370
        0x10002bae:    6838        8h      LDR      r0,[r7,#0]
        0x10002bb0:    05c0        ..      LSLS     r0,r0,#23
        0x10002bb2:    d505        ..      BPL      0x10002bc0 ; HardFault_Handler_Proc + 388
        0x10002bb4:    f24450f4    D..P    MOV      r0,#0x45f4
        0x10002bb8:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002bbc:    f001fbd8    ....    BL       puts ; 0x10004370
        0x10002bc0:    6838        8h      LDR      r0,[r7,#0]
        0x10002bc2:    0580        ..      LSLS     r0,r0,#22
        0x10002bc4:    d510        ..      BPL      0x10002be8 ; HardFault_Handler_Proc + 428
        0x10002bc6:    9901        ..      LDR      r1,[sp,#4]
        0x10002bc8:    f2443094    D..0    MOV      r0,#0x4394
        0x10002bcc:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002bd0:    f000ff64    ..d.    BL       __0printf ; 0x10003a9c
        0x10002bd4:    6838        8h      LDR      r0,[r7,#0]
        0x10002bd6:    0400        ..      LSLS     r0,r0,#16
        0x10002bd8:    d506        ..      BPL      0x10002be8 ; HardFault_Handler_Proc + 428
        0x10002bda:    6939        9i      LDR      r1,[r7,#0x10]
        0x10002bdc:    f24440b3    D..@    MOV      r0,#0x44b3
        0x10002be0:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002be4:    f000ff5a    ..Z.    BL       __0printf ; 0x10003a9c
        0x10002be8:    6838        8h      LDR      r0,[r7,#0]
        0x10002bea:    0540        @.      LSLS     r0,r0,#21
        0x10002bec:    d505        ..      BPL      0x10002bfa ; HardFault_Handler_Proc + 446
        0x10002bee:    f244508a    D..P    MOV      r0,#0x458a
        0x10002bf2:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002bf6:    f001fbbb    ....    BL       puts ; 0x10004370
        0x10002bfa:    6838        8h      LDR      r0,[r7,#0]
        0x10002bfc:    0500        ..      LSLS     r0,r0,#20
        0x10002bfe:    d505        ..      BPL      0x10002c0c ; HardFault_Handler_Proc + 464
        0x10002c00:    f6440011    D...    MOV      r0,#0x4811
        0x10002c04:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002c08:    f001fbb2    ....    BL       puts ; 0x10004370
        0x10002c0c:    6838        8h      LDR      r0,[r7,#0]
        0x10002c0e:    04c0        ..      LSLS     r0,r0,#19
        0x10002c10:    d505        ..      BPL      0x10002c1e ; HardFault_Handler_Proc + 482
        0x10002c12:    f644005d    D.].    MOV      r0,#0x485d
        0x10002c16:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002c1a:    f001fba9    ....    BL       puts ; 0x10004370
        0x10002c1e:    6838        8h      LDR      r0,[r7,#0]
        0x10002c20:    0480        ..      LSLS     r0,r0,#18
        0x10002c22:    d505        ..      BPL      0x10002c30 ; HardFault_Handler_Proc + 500
        0x10002c24:    f244701d    D..p    MOV      r0,#0x471d
        0x10002c28:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002c2c:    f001fba0    ....    BL       puts ; 0x10004370
        0x10002c30:    6838        8h      LDR      r0,[r7,#0]
        0x10002c32:    f5b03f80    ...?    CMP      r0,#0x10000
        0x10002c36:    d344        D.      BCC      0x10002cc2 ; HardFault_Handler_Proc + 646
        0x10002c38:    f64400b8    D...    MOV      r0,#0x48b8
        0x10002c3c:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002c40:    f001fb96    ....    BL       puts ; 0x10004370
        0x10002c44:    6838        8h      LDR      r0,[r7,#0]
        0x10002c46:    03c0        ..      LSLS     r0,r0,#15
        0x10002c48:    d505        ..      BPL      0x10002c56 ; HardFault_Handler_Proc + 538
        0x10002c4a:    f2445016    D..P    MOV      r0,#0x4516
        0x10002c4e:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002c52:    f001fb8d    ....    BL       puts ; 0x10004370
        0x10002c56:    6838        8h      LDR      r0,[r7,#0]
        0x10002c58:    0380        ..      LSLS     r0,r0,#14
        0x10002c5a:    d505        ..      BPL      0x10002c68 ; HardFault_Handler_Proc + 556
        0x10002c5c:    f244608d    D..`    MOV      r0,#0x468d
        0x10002c60:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002c64:    f001fb84    ....    BL       puts ; 0x10004370
        0x10002c68:    6838        8h      LDR      r0,[r7,#0]
        0x10002c6a:    0340        @.      LSLS     r0,r0,#13
        0x10002c6c:    d505        ..      BPL      0x10002c7a ; HardFault_Handler_Proc + 574
        0x10002c6e:    f24440e8    D..@    MOV      r0,#0x44e8
        0x10002c72:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002c76:    f001fb7b    ..{.    BL       puts ; 0x10004370
        0x10002c7a:    6838        8h      LDR      r0,[r7,#0]
        0x10002c7c:    0300        ..      LSLS     r0,r0,#12
        0x10002c7e:    d505        ..      BPL      0x10002c8c ; HardFault_Handler_Proc + 592
        0x10002c80:    f2446021    D.!`    MOV      r0,#0x4621
        0x10002c84:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002c88:    f001fb72    ..r.    BL       puts ; 0x10004370
        0x10002c8c:    6838        8h      LDR      r0,[r7,#0]
        0x10002c8e:    02c0        ..      LSLS     r0,r0,#11
        0x10002c90:    d505        ..      BPL      0x10002c9e ; HardFault_Handler_Proc + 610
        0x10002c92:    f2446061    D.a`    MOV      r0,#0x4661
        0x10002c96:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002c9a:    f001fb69    ..i.    BL       puts ; 0x10004370
        0x10002c9e:    6838        8h      LDR      r0,[r7,#0]
        0x10002ca0:    01c0        ..      LSLS     r0,r0,#7
        0x10002ca2:    d505        ..      BPL      0x10002cb0 ; HardFault_Handler_Proc + 628
        0x10002ca4:    f24450c1    D..P    MOV      r0,#0x45c1
        0x10002ca8:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002cac:    f001fb60    ..`.    BL       puts ; 0x10004370
        0x10002cb0:    6838        8h      LDR      r0,[r7,#0]
        0x10002cb2:    0180        ..      LSLS     r0,r0,#6
        0x10002cb4:    d505        ..      BPL      0x10002cc2 ; HardFault_Handler_Proc + 646
        0x10002cb6:    f244504f    D.OP    MOV      r0,#0x454f
        0x10002cba:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002cbe:    f001fb57    ..W.    BL       puts ; 0x10004370
        0x10002cc2:    f000fc15    ....    BL       app_debug_printf ; 0x100034f0
        0x10002cc6:    bf00        ..      NOP      
        0x10002cc8:    e7fe        ..      B        0x10002cc8 ; HardFault_Handler_Proc + 652
        0x10002cca:    bf00        ..      NOP      
    $d
        0x10002ccc:    6e697355    Usin    DCD    1852404565
        0x10002cd0:    33752067    g u3    DCD    863314023
        0x10002cd4:    70735032    2Psp    DCD    1886605362
        0x10002cd8:    0000002e    ....    DCD    46
        0x10002cdc:    63617453    Stac    DCD    1667331155
        0x10002ce0:    7266206b    k fr    DCD    1919295595
        0x10002ce4:    3a656d61    ame:    DCD    979725665
        0x10002ce8:    00000000    ....    DCD    0
        0x10002cec:    20203052    R0      DCD    538980434
        0x10002cf0:    7830203a    : 0x    DCD    2016419898
        0x10002cf4:    58383025    %08X    DCD    1480077349
        0x10002cf8:    0000000a    ....    DCD    10
        0x10002cfc:    20203152    R1      DCD    538980690
        0x10002d00:    7830203a    : 0x    DCD    2016419898
        0x10002d04:    58383025    %08X    DCD    1480077349
        0x10002d08:    0000000a    ....    DCD    10
        0x10002d0c:    20203252    R2      DCD    538980946
        0x10002d10:    7830203a    : 0x    DCD    2016419898
        0x10002d14:    58383025    %08X    DCD    1480077349
        0x10002d18:    0000000a    ....    DCD    10
        0x10002d1c:    20203352    R3      DCD    538981202
        0x10002d20:    7830203a    : 0x    DCD    2016419898
        0x10002d24:    58383025    %08X    DCD    1480077349
        0x10002d28:    0000000a    ....    DCD    10
        0x10002d2c:    20323152    R12     DCD    540160338
        0x10002d30:    7830203a    : 0x    DCD    2016419898
        0x10002d34:    58383025    %08X    DCD    1480077349
        0x10002d38:    0000000a    ....    DCD    10
        0x10002d3c:    2020524c    LR      DCD    538989132
        0x10002d40:    7830203a    : 0x    DCD    2016419898
        0x10002d44:    58383025    %08X    DCD    1480077349
        0x10002d48:    0000000a    ....    DCD    10
        0x10002d4c:    20204350    PC      DCD    538985296
        0x10002d50:    7830203a    : 0x    DCD    2016419898
        0x10002d54:    58383025    %08X    DCD    1480077349
        0x10002d58:    0000000a    ....    DCD    10
        0x10002d5c:    52535078    xPSR    DCD    1381191800
        0x10002d60:    7830203a    : 0x    DCD    2016419898
        0x10002d64:    58383025    %08X    DCD    1480077349
        0x10002d68:    0000000a    ....    DCD    10
    $t
    I2C_HAL_GetLastError
        0x10002d6c:    f24b0034    K.4.    MOV      r0,#0xb034
        0x10002d70:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002d74:    6800        .h      LDR      r0,[r0,#0]
        0x10002d76:    4770        pG      BX       lr
    I2C_HAL_GetTickMs
        0x10002d78:    f24b0064    K.d.    MOV      r0,#0xb064
        0x10002d7c:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002d80:    6800        .h      LDR      r0,[r0,#0]
        0x10002d82:    4770        pG      BX       lr
    I2C_HAL_IsBusy
        0x10002d84:    f24b0028    K.(.    MOV      r0,#0xb028
        0x10002d88:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002d8c:    7800        .x      LDRB     r0,[r0,#0]
        0x10002d8e:    4770        pG      BX       lr
    I2C_HAL_MasterDMA_Init
        0x10002d90:    e92d41f0    -..A    PUSH     {r4-r8,lr}
        0x10002d94:    b084        ..      SUB      sp,sp,#0x10
        0x10002d96:    f24b005f    K._.    MOV      r0,#0xb05f
        0x10002d9a:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002d9e:    2100        .!      MOVS     r1,#0
        0x10002da0:    7001        .p      STRB     r1,[r0,#0]
        0x10002da2:    f24b0031    K.1.    MOV      r0,#0xb031
        0x10002da6:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002daa:    7001        .p      STRB     r1,[r0,#0]
        0x10002dac:    f24b0028    K.(.    MOV      r0,#0xb028
        0x10002db0:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002db4:    7001        .p      STRB     r1,[r0,#0]
        0x10002db6:    f24b0005    K...    MOV      r0,#0xb005
        0x10002dba:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002dbe:    2201        ."      MOVS     r2,#1
        0x10002dc0:    7002        .p      STRB     r2,[r0,#0]
        0x10002dc2:    f24b0068    K.h.    MOV      r0,#0xb068
        0x10002dc6:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002dca:    7001        .p      STRB     r1,[r0,#0]
        0x10002dcc:    f24b0044    K.D.    MOV      r0,#0xb044
        0x10002dd0:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002dd4:    7001        .p      STRB     r1,[r0,#0]
        0x10002dd6:    f24b0034    K.4.    MOV      r0,#0xb034
        0x10002dda:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002dde:    6001        .`      STR      r1,[r0,#0]
        0x10002de0:    f24b0064    K.d.    MOV      r0,#0xb064
        0x10002de4:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002de8:    6001        .`      STR      r1,[r0,#0]
        0x10002dea:    2004        .       MOVS     r0,#4
        0x10002dec:    9101        ..      STR      r1,[sp,#4]
        0x10002dee:    f000fd6e    ..n.    BL       $Ven$TT$L$$rom_hw_crg_enable_clk_gate ; 0x100038ce
        0x10002df2:    bb00        ..      CBNZ     r0,0x10002e36 ; I2C_HAL_MasterDMA_Init + 166
        0x10002df4:    f2420400    B...    MOVW     r4,#0x2000
        0x10002df8:    f2c60405    ....    MOVT     r4,#0x6005
        0x10002dfc:    4620         F      MOV      r0,r4
        0x10002dfe:    f000fd6b    ..k.    BL       $Ven$TT$L$$rom_hw_stim_stop ; 0x100038d8
        0x10002e02:    4620         F      MOV      r0,r4
        0x10002e04:    f000fd6d    ..m.    BL       $Ven$TT$L$$rom_hw_stim_clear_count ; 0x100038e2
        0x10002e08:    4620         F      MOV      r0,r4
        0x10002e0a:    2100        .!      MOVS     r1,#0
        0x10002e0c:    f000fd6e    ..n.    BL       $Ven$TT$L$$rom_hw_stim_set_prescale ; 0x100038ec
        0x10002e10:    b988        ..      CBNZ     r0,0x10002e36 ; I2C_HAL_MasterDMA_Init + 166
        0x10002e12:    4620         F      MOV      r0,r4
        0x10002e14:    213f        ?!      MOVS     r1,#0x3f
        0x10002e16:    f000fd6e    ..n.    BL       $Ven$TT$L$$rom_hw_stim_disable_interrupt ; 0x100038f6
        0x10002e1a:    4620         F      MOV      r0,r4
        0x10002e1c:    2131        1!      MOVS     r1,#0x31
        0x10002e1e:    f000fd6f    ..o.    BL       $Ven$TT$L$$rom_hw_stim_clear_interrupt_flag ; 0x10003900
        0x10002e22:    2001        .       MOVS     r0,#1
        0x10002e24:    2131        1!      MOVS     r1,#0x31
        0x10002e26:    f000fd70    ..p.    BL       $Ven$TT$L$$rom_hw_sys_ctrl_enable_peri_int ; 0x1000390a
        0x10002e2a:    b920         .      CBNZ     r0,0x10002e36 ; I2C_HAL_MasterDMA_Init + 166
        0x10002e2c:    4620         F      MOV      r0,r4
        0x10002e2e:    2101        .!      MOVS     r1,#1
        0x10002e30:    f000fd70    ..p.    BL       $Ven$TT$L$$rom_hw_stim_enable_interrupt ; 0x10003914
        0x10002e34:    b120         .      CBZ      r0,0x10002e40 ; I2C_HAL_MasterDMA_Init + 176
        0x10002e36:    2003        .       MOVS     r0,#3
        0x10002e38:    b328        (.      CBZ      r0,0x10002e86 ; I2C_HAL_MasterDMA_Init + 246
        0x10002e3a:    b004        ..      ADD      sp,sp,#0x10
        0x10002e3c:    e8bd81f0    ....    POP      {r4-r8,pc}
        0x10002e40:    a901        ..      ADD      r1,sp,#4
        0x10002e42:    4620         F      MOV      r0,r4
        0x10002e44:    f000fd6b    ..k.    BL       $Ven$TT$L$$rom_hw_stim_get_count ; 0x1000391e
        0x10002e48:    9801        ..      LDR      r0,[sp,#4]
        0x10002e4a:    2100        .!      MOVS     r1,#0
        0x10002e4c:    f1000221    ..!.    ADD      r2,r0,#0x21
        0x10002e50:    4620         F      MOV      r0,r4
        0x10002e52:    f000fd69    ..i.    BL       $Ven$TT$L$$rom_hw_stim_set_compare ; 0x10003928
        0x10002e56:    f24e1004    N...    MOV      r0,#0xe104
        0x10002e5a:    f24e4231    N.1B    MOV      r2,#0xe431
        0x10002e5e:    f2ce0000    ....    MOVT     r0,#0xe000
        0x10002e62:    f44f3100    O..1    MOV      r1,#0x20000
        0x10002e66:    f2ce0200    ....    MOVT     r2,#0xe000
        0x10002e6a:    2360        `#      MOVS     r3,#0x60
        0x10002e6c:    f8c01180    ....    STR      r1,[r0,#0x180]
        0x10002e70:    7013        .p      STRB     r3,[r2,#0]
        0x10002e72:    6001        .`      STR      r1,[r0,#0]
        0x10002e74:    4620         F      MOV      r0,r4
        0x10002e76:    b662        b.      CPSIE    i
        0x10002e78:    f000fd5b    ..[.    BL       $Ven$TT$L$$rom_hw_stim_start ; 0x10003932
        0x10002e7c:    2800        .(      CMP      r0,#0
        0x10002e7e:    bf18        ..      IT       NE
        0x10002e80:    2003        .       MOVNE    r0,#3
        0x10002e82:    2800        .(      CMP      r0,#0
        0x10002e84:    d1d9        ..      BNE      0x10002e3a ; I2C_HAL_MasterDMA_Init + 170
        0x10002e86:    f2430400    C...    MOVW     r4,#0x3000
        0x10002e8a:    201c        .       MOVS     r0,#0x1c
        0x10002e8c:    f2c60400    ....    MOVT     r4,#0x6000
        0x10002e90:    f000fd1d    ....    BL       $Ven$TT$L$$rom_hw_crg_enable_clk_gate ; 0x100038ce
        0x10002e94:    f2420000    B...    MOVW     r0,#0x2000
        0x10002e98:    f2c60005    ....    MOVT     r0,#0x6005
        0x10002e9c:    f5a045df    ...E    SUB      r5,r0,#0x6f80
        0x10002ea0:    4628        (F      MOV      r0,r5
        0x10002ea2:    f44f7100    O..q    MOV      r1,#0x200
        0x10002ea6:    221a        ."      MOVS     r2,#0x1a
        0x10002ea8:    f000fd48    ..H.    BL       $Ven$TT$L$$rom_hw_gpio_set_pin_pid ; 0x1000393c
        0x10002eac:    4628        (F      MOV      r0,r5
        0x10002eae:    2180        .!      MOVS     r1,#0x80
        0x10002eb0:    221b        ."      MOVS     r2,#0x1b
        0x10002eb2:    f000fd43    ..C.    BL       $Ven$TT$L$$rom_hw_gpio_set_pin_pid ; 0x1000393c
        0x10002eb6:    4628        (F      MOV      r0,r5
        0x10002eb8:    f44f7100    O..q    MOV      r1,#0x200
        0x10002ebc:    2200        ."      MOVS     r2,#0
        0x10002ebe:    2700        .'      MOVS     r7,#0
        0x10002ec0:    f000fd41    ..A.    BL       $Ven$TT$L$$rom_hw_gpio_set_pin_pull_mode ; 0x10003946
        0x10002ec4:    4628        (F      MOV      r0,r5
        0x10002ec6:    2180        .!      MOVS     r1,#0x80
        0x10002ec8:    2200        ."      MOVS     r2,#0
        0x10002eca:    f000fd3c    ..<.    BL       $Ven$TT$L$$rom_hw_gpio_set_pin_pull_mode ; 0x10003946
        0x10002ece:    4628        (F      MOV      r0,r5
        0x10002ed0:    f44f6180    O..a    MOV      r1,#0x400
        0x10002ed4:    2200        ."      MOVS     r2,#0
        0x10002ed6:    f000fd31    ..1.    BL       $Ven$TT$L$$rom_hw_gpio_set_pin_pid ; 0x1000393c
        0x10002eda:    4628        (F      MOV      r0,r5
        0x10002edc:    f44f6180    O..a    MOV      r1,#0x400
        0x10002ee0:    2201        ."      MOVS     r2,#1
        0x10002ee2:    f04f0801    O...    MOV      r8,#1
        0x10002ee6:    f000fd33    ..3.    BL       $Ven$TT$L$$rom_hw_gpio_set_pin_input_output ; 0x10003950
        0x10002eea:    4628        (F      MOV      r0,r5
        0x10002eec:    f44f6180    O..a    MOV      r1,#0x400
        0x10002ef0:    2201        ."      MOVS     r2,#1
        0x10002ef2:    f000fd32    ..2.    BL       $Ven$TT$L$$rom_hw_gpio_set_pin_drive_strength ; 0x1000395a
        0x10002ef6:    4628        (F      MOV      r0,r5
        0x10002ef8:    f44f6180    O..a    MOV      r1,#0x400
        0x10002efc:    2201        ."      MOVS     r2,#1
        0x10002efe:    f000fd31    ..1.    BL       $Ven$TT$L$$rom_hw_gpio_set_pin_output_level ; 0x10003964
        0x10002f02:    e9cd7702    ...w    STRD     r7,r7,[sp,#8]
        0x10002f06:    2064        d       MOVS     r0,#0x64
        0x10002f08:    f89d100e    ....    LDRB     r1,[sp,#0xe]
        0x10002f0c:    9001        ..      STR      r0,[sp,#4]
        0x10002f0e:    2044        D       MOVS     r0,#0x44
        0x10002f10:    f8ad0008    ....    STRH     r0,[sp,#8]
        0x10002f14:    f00100e0    ....    AND      r0,r1,#0xe0
        0x10002f18:    3019        .0      ADDS     r0,r0,#0x19
        0x10002f1a:    f88d000e    ....    STRB     r0,[sp,#0xe]
        0x10002f1e:    a901        ..      ADD      r1,sp,#4
        0x10002f20:    4620         F      MOV      r0,r4
        0x10002f22:    f000fd24    ..$.    BL       $Ven$TT$L$$rom_hw_i2c_master_init ; 0x1000396e
        0x10002f26:    2017        .       MOVS     r0,#0x17
        0x10002f28:    f000fcd1    ....    BL       $Ven$TT$L$$rom_hw_crg_enable_clk_gate ; 0x100038ce
        0x10002f2c:    2800        .(      CMP      r0,#0
        0x10002f2e:    d147        G.      BNE      0x10002fc0 ; I2C_HAL_MasterDMA_Init + 560
        0x10002f30:    f24b0148    K.H.    MOV      r1,#0xb048
        0x10002f34:    f2c20100    ....    MOVT     r1,#0x2000
        0x10002f38:    2007        .       MOVS     r0,#7
        0x10002f3a:    e9c17703    ...w    STRD     r7,r7,[r1,#0xc]
        0x10002f3e:    7408        .t      STRB     r0,[r1,#0x10]
        0x10002f40:    1d20         .      ADDS     r0,r4,#4
        0x10002f42:    6008        .`      STR      r0,[r1,#0]
        0x10002f44:    89c8        ..      LDRH     r0,[r1,#0xe]
        0x10002f46:    f24b066c    K.l.    MOV      r6,#0xb06c
        0x10002f4a:    f4004060    ..`@    AND      r0,r0,#0xe000
        0x10002f4e:    f2481580    H...    MOV      r5,#0x8180
        0x10002f52:    f2c20600    ....    MOVT     r6,#0x2000
        0x10002f56:    3048        H0      ADDS     r0,r0,#0x48
        0x10002f58:    f2c50500    ....    MOVT     r5,#0x5000
        0x10002f5c:    604f        O`      STR      r7,[r1,#4]
        0x10002f5e:    e9c67700    ...w    STRD     r7,r7,[r6,#0]
        0x10002f62:    e9c67702    ...w    STRD     r7,r7,[r6,#8]
        0x10002f66:    6137        7a      STR      r7,[r6,#0x10]
        0x10002f68:    27c8        .'      MOVS     r7,#0xc8
        0x10002f6a:    81c8        ..      STRH     r0,[r1,#0xe]
        0x10002f6c:    4628        (F      MOV      r0,r5
        0x10002f6e:    608f        .`      STR      r7,[r1,#8]
        0x10002f70:    f8a1800c    ....    STRH     r8,[r1,#0xc]
        0x10002f74:    f000fd00    ....    BL       $Ven$TT$L$$rom_hw_dma_init ; 0x10003978
        0x10002f78:    bb10        ..      CBNZ     r0,0x10002fc0 ; I2C_HAL_MasterDMA_Init + 560
        0x10002f7a:    2006        .       MOVS     r0,#6
        0x10002f7c:    7430        0t      STRB     r0,[r6,#0x10]
        0x10002f7e:    2000        .       MOVS     r0,#0
        0x10002f80:    89f1        ..      LDRH     r1,[r6,#0xe]
        0x10002f82:    e8860091    ....    STM      r6,{r0,r4,r7}
        0x10002f86:    2001        .       MOVS     r0,#1
        0x10002f88:    81b0        ..      STRH     r0,[r6,#0xc]
        0x10002f8a:    f4014060    ..`@    AND      r0,r1,#0xe000
        0x10002f8e:    f5007001    ...p    ADD      r0,r0,#0x204
        0x10002f92:    f1050440    ..@.    ADD      r4,r5,#0x40
        0x10002f96:    81f0        ..      STRH     r0,[r6,#0xe]
        0x10002f98:    4620         F      MOV      r0,r4
        0x10002f9a:    4631        1F      MOV      r1,r6
        0x10002f9c:    f000fcec    ....    BL       $Ven$TT$L$$rom_hw_dma_init ; 0x10003978
        0x10002fa0:    b970        p.      CBNZ     r0,0x10002fc0 ; I2C_HAL_MasterDMA_Init + 560
        0x10002fa2:    2001        .       MOVS     r0,#1
        0x10002fa4:    2124        $!      MOVS     r1,#0x24
        0x10002fa6:    f000fcb0    ....    BL       $Ven$TT$L$$rom_hw_sys_ctrl_enable_peri_int ; 0x1000390a
        0x10002faa:    b948        H.      CBNZ     r0,0x10002fc0 ; I2C_HAL_MasterDMA_Init + 560
        0x10002fac:    4628        (F      MOV      r0,r5
        0x10002fae:    2106        .!      MOVS     r1,#6
        0x10002fb0:    f000fce7    ....    BL       $Ven$TT$L$$rom_hw_dma_set_interrupt_channel ; 0x10003982
        0x10002fb4:    b920         .      CBNZ     r0,0x10002fc0 ; I2C_HAL_MasterDMA_Init + 560
        0x10002fb6:    4620         F      MOV      r0,r4
        0x10002fb8:    2106        .!      MOVS     r1,#6
        0x10002fba:    f000fce2    ....    BL       $Ven$TT$L$$rom_hw_dma_set_interrupt_channel ; 0x10003982
        0x10002fbe:    b118        ..      CBZ      r0,0x10002fc8 ; I2C_HAL_MasterDMA_Init + 568
        0x10002fc0:    2003        .       MOVS     r0,#3
        0x10002fc2:    b004        ..      ADD      sp,sp,#0x10
        0x10002fc4:    e8bd81f0    ....    POP      {r4-r8,pc}
        0x10002fc8:    f24e1004    N...    MOV      r0,#0xe104
        0x10002fcc:    f2ce0000    ....    MOVT     r0,#0xe000
        0x10002fd0:    2110        .!      MOVS     r1,#0x10
        0x10002fd2:    2260        `"      MOVS     r2,#0x60
        0x10002fd4:    f8c01180    ....    STR      r1,[r0,#0x180]
        0x10002fd8:    f8802320    .. #    STRB     r2,[r0,#0x320]
        0x10002fdc:    6001        .`      STR      r1,[r0,#0]
        0x10002fde:    2000        .       MOVS     r0,#0
        0x10002fe0:    b004        ..      ADD      sp,sp,#0x10
        0x10002fe2:    e8bd81f0    ....    POP      {r4-r8,pc}
        0x10002fe6:    0000        ..      MOVS     r0,r0
    I2C_HAL_MasterReadDMA
        0x10002fe8:    2800        .(      CMP      r0,#0
        0x10002fea:    f04f0302    O...    MOV      r3,#2
        0x10002fee:    d073        s.      BEQ      0x100030d8 ; I2C_HAL_MasterReadDMA + 240
        0x10002ff0:    e92d41f0    -..A    PUSH     {r4-r8,lr}
        0x10002ff4:    f1a10711    ....    SUB      r7,r1,#0x11
        0x10002ff8:    f1170f10    ....    CMN      r7,#0x10
        0x10002ffc:    d36a        j.      BCC      0x100030d4 ; I2C_HAL_MasterReadDMA + 236
        0x10002ffe:    f24b0728    K.(.    MOV      r7,#0xb028
        0x10003002:    f2c20700    ....    MOVT     r7,#0x2000
        0x10003006:    783b        ;x      LDRB     r3,[r7,#0]
        0x10003008:    2b00        .+      CMP      r3,#0
        0x1000300a:    f04f0301    O...    MOV      r3,#1
        0x1000300e:    d161        a.      BNE      0x100030d4 ; I2C_HAL_MasterReadDMA + 236
        0x10003010:    703b        ;p      STRB     r3,[r7,#0]
        0x10003012:    f24b0331    K.1.    MOV      r3,#0xb031
        0x10003016:    f2c20300    ....    MOVT     r3,#0x2000
        0x1000301a:    2700        .'      MOVS     r7,#0
        0x1000301c:    701f        .p      STRB     r7,[r3,#0]
        0x1000301e:    f24b0334    K.4.    MOV      r3,#0xb034
        0x10003022:    f2c20300    ....    MOVT     r3,#0x2000
        0x10003026:    601f        .`      STR      r7,[r3,#0]
        0x10003028:    f24b0305    K...    MOV      r3,#0xb005
        0x1000302c:    f2c20300    ....    MOVT     r3,#0x2000
        0x10003030:    701a        .p      STRB     r2,[r3,#0]
        0x10003032:    f24b0244    K.D.    MOV      r2,#0xb044
        0x10003036:    f2c20200    ....    MOVT     r2,#0x2000
        0x1000303a:    7017        .p      STRB     r7,[r2,#0]
        0x1000303c:    f24b023c    K.<.    MOV      r2,#0xb03c
        0x10003040:    f2c20200    ....    MOVT     r2,#0x2000
        0x10003044:    6010        .`      STR      r0,[r2,#0]
        0x10003046:    f24b025c    K.\.    MOV      r2,#0xb05c
        0x1000304a:    f2430400    C...    MOVW     r4,#0x3000
        0x1000304e:    f2c20200    ....    MOVT     r2,#0x2000
        0x10003052:    f2c60400    ....    MOVT     r4,#0x6000
        0x10003056:    8011        ..      STRH     r1,[r2,#0]
        0x10003058:    4607        .F      MOV      r7,r0
        0x1000305a:    4620         F      MOV      r0,r4
        0x1000305c:    460e        .F      MOV      r6,r1
        0x1000305e:    2101        .!      MOVS     r1,#1
        0x10003060:    f04f0801    O...    MOV      r8,#1
        0x10003064:    f000fc92    ....    BL       $Ven$TT$L$$rom_hw_i2c_set_mode ; 0x1000398c
        0x10003068:    4620         F      MOV      r0,r4
        0x1000306a:    2102        .!      MOVS     r1,#2
        0x1000306c:    f000fc93    ....    BL       $Ven$TT$L$$rom_hw_i2c_master_set_trx_mode ; 0x10003996
        0x10003070:    4620         F      MOV      r0,r4
        0x10003072:    f000fc95    ....    BL       $Ven$TT$L$$rom_hw_i2c_master_enable_stretch ; 0x100039a0
        0x10003076:    2020                MOVS     r0,#0x20
        0x10003078:    64a0        .d      STR      r0,[r4,#0x48]
        0x1000307a:    f64f75ff    O..u    MOV      r5,#0xffff
        0x1000307e:    b2f1        ..      UXTB     r1,r6
        0x10003080:    4620         F      MOV      r0,r4
        0x10003082:    6125        %a      STR      r5,[r4,#0x10]
        0x10003084:    f8c48044    ..D.    STR      r8,[r4,#0x44]
        0x10003088:    f8c48040    ..@.    STR      r8,[r4,#0x40]
        0x1000308c:    f000fc8d    ....    BL       $Ven$TT$L$$rom_hw_i2c_master_set_rxfifo_full_value ; 0x100039aa
        0x10003090:    4620         F      MOV      r0,r4
        0x10003092:    2101        .!      MOVS     r1,#1
        0x10003094:    f000fc8e    ....    BL       $Ven$TT$L$$rom_hw_i2c_set_rxfifo_thld ; 0x100039b4
        0x10003098:    f248118c    H...    MOV      r1,#0x818c
        0x1000309c:    1d20         .      ADDS     r0,r4,#4
        0x1000309e:    f2c50100    ....    MOVT     r1,#0x5000
        0x100030a2:    6088        .`      STR      r0,[r1,#8]
        0x100030a4:    60cf        .`      STR      r7,[r1,#0xc]
        0x100030a6:    6808        .h      LDR      r0,[r1,#0]
        0x100030a8:    2300        .#      MOVS     r3,#0
        0x100030aa:    43a8        .C      BICS     r0,r0,r5
        0x100030ac:    4430        0D      ADD      r0,r0,r6
        0x100030ae:    6008        .`      STR      r0,[r1,#0]
        0x100030b0:    f24b005f    K._.    MOV      r0,#0xb05f
        0x100030b4:    f2c20000    ....    MOVT     r0,#0x2000
        0x100030b8:    2105        .!      MOVS     r1,#5
        0x100030ba:    f8c48048    ..H.    STR      r8,[r4,#0x48]
        0x100030be:    7001        .p      STRB     r1,[r0,#0]
        0x100030c0:    f24b0064    K.d.    MOV      r0,#0xb064
        0x100030c4:    f2c20000    ....    MOVT     r0,#0x2000
        0x100030c8:    6800        .h      LDR      r0,[r0,#0]
        0x100030ca:    f24b0160    K.`.    MOV      r1,#0xb060
        0x100030ce:    f2c20100    ....    MOVT     r1,#0x2000
        0x100030d2:    6008        .`      STR      r0,[r1,#0]
        0x100030d4:    e8bd41f0    ...A    POP      {r4-r8,lr}
        0x100030d8:    4618        .F      MOV      r0,r3
        0x100030da:    4770        pG      BX       lr
    I2C_HAL_MasterWriteDMA
        0x100030dc:    4603        .F      MOV      r3,r0
        0x100030de:    2800        .(      CMP      r0,#0
        0x100030e0:    f04f0002    O...    MOV      r0,#2
        0x100030e4:    bf18        ..      IT       NE
        0x100030e6:    2900        .)      CMPNE    r1,#0
        0x100030e8:    d100        ..      BNE      0x100030ec ; I2C_HAL_MasterWriteDMA + 16
        0x100030ea:    4770        pG      BX       lr
        0x100030ec:    e92d4ff0    -..O    PUSH     {r4-r11,lr}
        0x100030f0:    b081        ..      SUB      sp,sp,#4
        0x100030f2:    f24b0a28    K.(.    MOV      r10,#0xb028
        0x100030f6:    f2c20a00    ....    MOVT     r10,#0x2000
        0x100030fa:    f89a0000    ....    LDRB     r0,[r10,#0]
        0x100030fe:    2800        .(      CMP      r0,#0
        0x10003100:    f04f0001    O...    MOV      r0,#1
        0x10003104:    f0408096    @...    BNE.W    0x10003234 ; I2C_HAL_MasterWriteDMA + 344
        0x10003108:    f24b0831    K.1.    MOV      r8,#0xb031
        0x1000310c:    f24b0934    K.4.    MOV      r9,#0xb034
        0x10003110:    f88a0000    ....    STRB     r0,[r10,#0]
        0x10003114:    f2c20800    ....    MOVT     r8,#0x2000
        0x10003118:    2000        .       MOVS     r0,#0
        0x1000311a:    f2c20900    ....    MOVT     r9,#0x2000
        0x1000311e:    f2430400    C...    MOVW     r4,#0x3000
        0x10003122:    f8880000    ....    STRB     r0,[r8,#0]
        0x10003126:    f8c90000    ....    STR      r0,[r9,#0]
        0x1000312a:    f24b0005    K...    MOV      r0,#0xb005
        0x1000312e:    f2c60400    ....    MOVT     r4,#0x6000
        0x10003132:    f2c20000    ....    MOVT     r0,#0x2000
        0x10003136:    f2481bc0    H...    MOV      r11,#0x81c0
        0x1000313a:    7002        .p      STRB     r2,[r0,#0]
        0x1000313c:    4620         F      MOV      r0,r4
        0x1000313e:    460d        .F      MOV      r5,r1
        0x10003140:    2101        .!      MOVS     r1,#1
        0x10003142:    f2c50b00    ....    MOVT     r11,#0x5000
        0x10003146:    2701        .'      MOVS     r7,#1
        0x10003148:    461e        .F      MOV      r6,r3
        0x1000314a:    f000fc1f    ....    BL       $Ven$TT$L$$rom_hw_i2c_set_mode ; 0x1000398c
        0x1000314e:    4620         F      MOV      r0,r4
        0x10003150:    2101        .!      MOVS     r1,#1
        0x10003152:    f000fc20    .. .    BL       $Ven$TT$L$$rom_hw_i2c_master_set_trx_mode ; 0x10003996
        0x10003156:    4620         F      MOV      r0,r4
        0x10003158:    f000fc22    ..".    BL       $Ven$TT$L$$rom_hw_i2c_master_enable_stretch ; 0x100039a0
        0x1000315c:    2020                MOVS     r0,#0x20
        0x1000315e:    64a0        .d      STR      r0,[r4,#0x48]
        0x10003160:    f64f70ff    O..p    MOV      r0,#0xffff
        0x10003164:    6120         a      STR      r0,[r4,#0x10]
        0x10003166:    6467        gd      STR      r7,[r4,#0x44]
        0x10003168:    6427        'd      STR      r7,[r4,#0x40]
        0x1000316a:    f8cb6014    ...`    STR      r6,[r11,#0x14]
        0x1000316e:    f8cb4018    ...@    STR      r4,[r11,#0x18]
        0x10003172:    f8db100c    ....    LDR      r1,[r11,#0xc]
        0x10003176:    ea210000    !...    BIC      r0,r1,r0
        0x1000317a:    4428        (D      ADD      r0,r0,r5
        0x1000317c:    f8cb000c    ....    STR      r0,[r11,#0xc]
        0x10003180:    4658        XF      MOV      r0,r11
        0x10003182:    213f        ?!      MOVS     r1,#0x3f
        0x10003184:    f000fc1b    ....    BL       $Ven$TT$L$$rom_hw_dma_clear_interrupt_flag ; 0x100039be
        0x10003188:    b950        P.      CBNZ     r0,0x100031a0 ; I2C_HAL_MasterWriteDMA + 196
        0x1000318a:    4658        XF      MOV      r0,r11
        0x1000318c:    2102        .!      MOVS     r1,#2
        0x1000318e:    f000fc1b    ....    BL       $Ven$TT$L$$rom_hw_dma_enable_interrupt ; 0x100039c8
        0x10003192:    b928        (.      CBNZ     r0,0x100031a0 ; I2C_HAL_MasterWriteDMA + 196
        0x10003194:    4658        XF      MOV      r0,r11
        0x10003196:    2100        .!      MOVS     r1,#0
        0x10003198:    2700        .'      MOVS     r7,#0
        0x1000319a:    f000fc1a    ....    BL       $Ven$TT$L$$rom_hw_dma_set_interval_tx_index ; 0x100039d2
        0x1000319e:    b350        P.      CBZ      r0,0x100031f6 ; I2C_HAL_MasterWriteDMA + 282
        0x100031a0:    2003        .       MOVS     r0,#3
        0x100031a2:    b3a8        ..      CBZ      r0,0x10003210 ; I2C_HAL_MasterWriteDMA + 308
        0x100031a4:    f1ab0140    ..@.    SUB      r1,r11,#0x40
        0x100031a8:    4607        .F      MOV      r7,r0
        0x100031aa:    4608        .F      MOV      r0,r1
        0x100031ac:    f000fc16    ....    BL       $Ven$TT$L$$rom_hw_dma_disable ; 0x100039dc
        0x100031b0:    4658        XF      MOV      r0,r11
        0x100031b2:    f000fc13    ....    BL       $Ven$TT$L$$rom_hw_dma_disable ; 0x100039dc
        0x100031b6:    2002        .       MOVS     r0,#2
        0x100031b8:    64a0        .d      STR      r0,[r4,#0x48]
        0x100031ba:    4620         F      MOV      r0,r4
        0x100031bc:    f64f71ff    O..q    MOV      r1,#0xffff
        0x100031c0:    f000fc11    ....    BL       $Ven$TT$L$$rom_hw_i2c_clear_interrupt_flag ; 0x100039e6
        0x100031c4:    f24b0168    K.h.    MOV      r1,#0xb068
        0x100031c8:    f2c20100    ....    MOVT     r1,#0x2000
        0x100031cc:    2200        ."      MOVS     r2,#0
        0x100031ce:    700a        .p      STRB     r2,[r1,#0]
        0x100031d0:    f24b0144    K.D.    MOV      r1,#0xb044
        0x100031d4:    f2c20100    ....    MOVT     r1,#0x2000
        0x100031d8:    700a        .p      STRB     r2,[r1,#0]
        0x100031da:    f24b015f    K._.    MOV      r1,#0xb05f
        0x100031de:    f2c20100    ....    MOVT     r1,#0x2000
        0x100031e2:    700a        .p      STRB     r2,[r1,#0]
        0x100031e4:    2103        .!      MOVS     r1,#3
        0x100031e6:    4638        8F      MOV      r0,r7
        0x100031e8:    f88a2000    ...     STRB     r2,[r10,#0]
        0x100031ec:    f8c91000    ....    STR      r1,[r9,#0]
        0x100031f0:    f8881000    ....    STRB     r1,[r8,#0]
        0x100031f4:    e01e        ..      B        0x10003234 ; I2C_HAL_MasterWriteDMA + 344
        0x100031f6:    f24b0068    K.h.    MOV      r0,#0xb068
        0x100031fa:    f2c20000    ....    MOVT     r0,#0x2000
        0x100031fe:    7007        .p      STRB     r7,[r0,#0]
        0x10003200:    4658        XF      MOV      r0,r11
        0x10003202:    f000fbf5    ....    BL       $Ven$TT$L$$rom_hw_dma_enable ; 0x100039f0
        0x10003206:    2800        .(      CMP      r0,#0
        0x10003208:    bf18        ..      IT       NE
        0x1000320a:    2003        .       MOVNE    r0,#3
        0x1000320c:    2800        .(      CMP      r0,#0
        0x1000320e:    d1c9        ..      BNE      0x100031a4 ; I2C_HAL_MasterWriteDMA + 200
        0x10003210:    f24b015f    K._.    MOV      r1,#0xb05f
        0x10003214:    2001        .       MOVS     r0,#1
        0x10003216:    f2c20100    ....    MOVT     r1,#0x2000
        0x1000321a:    64a0        .d      STR      r0,[r4,#0x48]
        0x1000321c:    7008        .p      STRB     r0,[r1,#0]
        0x1000321e:    f24b0064    K.d.    MOV      r0,#0xb064
        0x10003222:    f2c20000    ....    MOVT     r0,#0x2000
        0x10003226:    6800        .h      LDR      r0,[r0,#0]
        0x10003228:    f24b0160    K.`.    MOV      r1,#0xb060
        0x1000322c:    f2c20100    ....    MOVT     r1,#0x2000
        0x10003230:    6008        .`      STR      r0,[r1,#0]
        0x10003232:    2000        .       MOVS     r0,#0
        0x10003234:    b001        ..      ADD      sp,sp,#4
        0x10003236:    e8bd4ff0    ...O    POP      {r4-r11,lr}
        0x1000323a:    4770        pG      BX       lr
    I2C_HAL_Process
        0x1000323c:    e92d41f0    -..A    PUSH     {r4-r8,lr}
        0x10003240:    f24b0628    K.(.    MOV      r6,#0xb028
        0x10003244:    f2c20600    ....    MOVT     r6,#0x2000
        0x10003248:    7830        0x      LDRB     r0,[r6,#0]
        0x1000324a:    2801        .(      CMP      r0,#1
        0x1000324c:    d13f        ?.      BNE      0x100032ce ; I2C_HAL_Process + 146
        0x1000324e:    f24b0764    K.d.    MOV      r7,#0xb064
        0x10003252:    f24b0560    K.`.    MOV      r5,#0xb060
        0x10003256:    f2c20700    ....    MOVT     r7,#0x2000
        0x1000325a:    f2c20500    ....    MOVT     r5,#0x2000
        0x1000325e:    6838        8h      LDR      r0,[r7,#0]
        0x10003260:    6829        )h      LDR      r1,[r5,#0]
        0x10003262:    f2430400    C...    MOVW     r4,#0x3000
        0x10003266:    1a40        @.      SUBS     r0,r0,r1
        0x10003268:    280a        .(      CMP      r0,#0xa
        0x1000326a:    f2c60400    ....    MOVT     r4,#0x6000
        0x1000326e:    d330        0.      BCC      0x100032d2 ; I2C_HAL_Process + 150
        0x10003270:    f2481580    H...    MOV      r5,#0x8180
        0x10003274:    f2c50500    ....    MOVT     r5,#0x5000
        0x10003278:    4628        (F      MOV      r0,r5
        0x1000327a:    f000fbaf    ....    BL       $Ven$TT$L$$rom_hw_dma_disable ; 0x100039dc
        0x1000327e:    f1050040    ..@.    ADD      r0,r5,#0x40
        0x10003282:    f000fbab    ....    BL       $Ven$TT$L$$rom_hw_dma_disable ; 0x100039dc
        0x10003286:    2002        .       MOVS     r0,#2
        0x10003288:    64a0        .d      STR      r0,[r4,#0x48]
        0x1000328a:    4620         F      MOV      r0,r4
        0x1000328c:    f64f71ff    O..q    MOV      r1,#0xffff
        0x10003290:    f000fba9    ....    BL       $Ven$TT$L$$rom_hw_i2c_clear_interrupt_flag ; 0x100039e6
        0x10003294:    f24b0068    K.h.    MOV      r0,#0xb068
        0x10003298:    f2c20000    ....    MOVT     r0,#0x2000
        0x1000329c:    2100        .!      MOVS     r1,#0
        0x1000329e:    7001        .p      STRB     r1,[r0,#0]
        0x100032a0:    f24b0044    K.D.    MOV      r0,#0xb044
        0x100032a4:    f2c20000    ....    MOVT     r0,#0x2000
        0x100032a8:    7001        .p      STRB     r1,[r0,#0]
        0x100032aa:    f24b005f    K._.    MOV      r0,#0xb05f
        0x100032ae:    f2c20000    ....    MOVT     r0,#0x2000
        0x100032b2:    7001        .p      STRB     r1,[r0,#0]
        0x100032b4:    f24b0034    K.4.    MOV      r0,#0xb034
        0x100032b8:    7031        1p      STRB     r1,[r6,#0]
        0x100032ba:    f2c20000    ....    MOVT     r0,#0x2000
        0x100032be:    2101        .!      MOVS     r1,#1
        0x100032c0:    6001        .`      STR      r1,[r0,#0]
        0x100032c2:    f24b0031    K.1.    MOV      r0,#0xb031
        0x100032c6:    f2c20000    ....    MOVT     r0,#0x2000
        0x100032ca:    2103        .!      MOVS     r1,#3
        0x100032cc:    7001        .p      STRB     r1,[r0,#0]
        0x100032ce:    e8bd81f0    ....    POP      {r4-r8,pc}
        0x100032d2:    f24b085f    K._.    MOV      r8,#0xb05f
        0x100032d6:    f2c20800    ....    MOVT     r8,#0x2000
        0x100032da:    6be0        .k      LDR      r0,[r4,#0x3c]
        0x100032dc:    f8981000    ....    LDRB     r1,[r8,#0]
        0x100032e0:    3901        .9      SUBS     r1,#1
        0x100032e2:    2908        .)      CMP      r1,#8
        0x100032e4:    d8f3        ..      BHI      0x100032ce ; I2C_HAL_Process + 146
        0x100032e6:    f000001f    ....    AND      r0,r0,#0x1f
        0x100032ea:    e8dff001    ....    TBB      [pc,r1]
    $d
        0x100032ee:    3f05        .?      DCW    16133
        0x100032f0:    4a0c2114    .!.J    DCD    1242308884
        0x100032f4:    00663254    T2f.    DCD    6697556
    $t
        0x100032f8:    1fc1        ..      SUBS     r1,r0,#7
        0x100032fa:    2902        .)      CMP      r1,#2
        0x100032fc:    d301        ..      BCC      0x10003302 ; I2C_HAL_Process + 198
        0x100032fe:    280e        .(      CMP      r0,#0xe
        0x10003300:    d141        A.      BNE      0x10003386 ; I2C_HAL_Process + 330
        0x10003302:    2002        .       MOVS     r0,#2
        0x10003304:    e053        S.      B        0x100033ae ; I2C_HAL_Process + 370
        0x10003306:    f1a00109    ....    SUB      r1,r0,#9
        0x1000330a:    2902        .)      CMP      r1,#2
        0x1000330c:    d301        ..      BCC      0x10003312 ; I2C_HAL_Process + 214
        0x1000330e:    280f        .(      CMP      r0,#0xf
        0x10003310:    d139        9.      BNE      0x10003386 ; I2C_HAL_Process + 330
        0x10003312:    2006        .       MOVS     r0,#6
        0x10003314:    e04b        K.      B        0x100033ae ; I2C_HAL_Process + 370
        0x10003316:    280e        .(      CMP      r0,#0xe
        0x10003318:    d135        5.      BNE      0x10003386 ; I2C_HAL_Process + 330
        0x1000331a:    f24b0005    K...    MOV      r0,#0xb005
        0x1000331e:    f2c20000    ....    MOVT     r0,#0x2000
        0x10003322:    7800        .x      LDRB     r0,[r0,#0]
        0x10003324:    2801        .(      CMP      r0,#1
        0x10003326:    d105        ..      BNE      0x10003334 ; I2C_HAL_Process + 248
        0x10003328:    2002        .       MOVS     r0,#2
        0x1000332a:    64a0        .d      STR      r0,[r4,#0x48]
        0x1000332c:    2004        .       MOVS     r0,#4
        0x1000332e:    e03e        >.      B        0x100033ae ; I2C_HAL_Process + 370
        0x10003330:    2800        .(      CMP      r0,#0
        0x10003332:    d1cc        ..      BNE      0x100032ce ; I2C_HAL_Process + 146
        0x10003334:    4620         F      MOV      r0,r4
        0x10003336:    f64f71ff    O..q    MOV      r1,#0xffff
        0x1000333a:    f000fb54    ..T.    BL       $Ven$TT$L$$rom_hw_i2c_clear_interrupt_flag ; 0x100039e6
        0x1000333e:    2000        .       MOVS     r0,#0
        0x10003340:    f8880000    ....    STRB     r0,[r8,#0]
        0x10003344:    7030        0p      STRB     r0,[r6,#0]
        0x10003346:    f24b0031    K.1.    MOV      r0,#0xb031
        0x1000334a:    f2c20000    ....    MOVT     r0,#0x2000
        0x1000334e:    2101        .!      MOVS     r1,#1
        0x10003350:    e7bc        ..      B        0x100032cc ; I2C_HAL_Process + 144
        0x10003352:    280d        .(      CMP      r0,#0xd
        0x10003354:    d1bb        ..      BNE      0x100032ce ; I2C_HAL_Process + 146
        0x10003356:    f24b0005    K...    MOV      r0,#0xb005
        0x1000335a:    f2c20000    ....    MOVT     r0,#0x2000
        0x1000335e:    7800        .x      LDRB     r0,[r0,#0]
        0x10003360:    2801        .(      CMP      r0,#1
        0x10003362:    d12e        ..      BNE      0x100033c2 ; I2C_HAL_Process + 390
        0x10003364:    2002        .       MOVS     r0,#2
        0x10003366:    64a0        .d      STR      r0,[r4,#0x48]
        0x10003368:    2009        .       MOVS     r0,#9
        0x1000336a:    e020         .      B        0x100033ae ; I2C_HAL_Process + 370
        0x1000336c:    f24b0068    K.h.    MOV      r0,#0xb068
        0x10003370:    f2c20000    ....    MOVT     r0,#0x2000
        0x10003374:    7801        .x      LDRB     r1,[r0,#0]
        0x10003376:    2901        .)      CMP      r1,#1
        0x10003378:    d1a9        ..      BNE      0x100032ce ; I2C_HAL_Process + 146
        0x1000337a:    2100        .!      MOVS     r1,#0
        0x1000337c:    7001        .p      STRB     r1,[r0,#0]
        0x1000337e:    2003        .       MOVS     r0,#3
        0x10003380:    e015        ..      B        0x100033ae ; I2C_HAL_Process + 370
        0x10003382:    280f        .(      CMP      r0,#0xf
        0x10003384:    d02c        ,.      BEQ      0x100033e0 ; I2C_HAL_Process + 420
        0x10003386:    280d        .(      CMP      r0,#0xd
        0x10003388:    f47fafa1    ....    BNE.W    0x100032ce ; I2C_HAL_Process + 146
        0x1000338c:    2002        .       MOVS     r0,#2
        0x1000338e:    e8bd41f0    ...A    POP      {r4-r8,lr}
        0x10003392:    f000b977    ..w.    B.W      i2c_fail ; 0x10003684
        0x10003396:    f24b0044    K.D.    MOV      r0,#0xb044
        0x1000339a:    f2c20000    ....    MOVT     r0,#0x2000
        0x1000339e:    7801        .x      LDRB     r1,[r0,#0]
        0x100033a0:    2901        .)      CMP      r1,#1
        0x100033a2:    f47faf94    ....    BNE.W    0x100032ce ; I2C_HAL_Process + 146
        0x100033a6:    2100        .!      MOVS     r1,#0
        0x100033a8:    7001        .p      STRB     r1,[r0,#0]
        0x100033aa:    2008        .       MOVS     r0,#8
        0x100033ac:    64a0        .d      STR      r0,[r4,#0x48]
        0x100033ae:    f8880000    ....    STRB     r0,[r8,#0]
        0x100033b2:    6838        8h      LDR      r0,[r7,#0]
        0x100033b4:    6028        (`      STR      r0,[r5,#0]
        0x100033b6:    e8bd81f0    ....    POP      {r4-r8,pc}
        0x100033ba:    2800        .(      CMP      r0,#0
        0x100033bc:    bf18        ..      IT       NE
        0x100033be:    e8bd81f0    ....    POPNE    {r4-r8,pc}
        0x100033c2:    4620         F      MOV      r0,r4
        0x100033c4:    f64f71ff    O..q    MOV      r1,#0xffff
        0x100033c8:    f000fb0d    ....    BL       $Ven$TT$L$$rom_hw_i2c_clear_interrupt_flag ; 0x100039e6
        0x100033cc:    2000        .       MOVS     r0,#0
        0x100033ce:    f8880000    ....    STRB     r0,[r8,#0]
        0x100033d2:    7030        0p      STRB     r0,[r6,#0]
        0x100033d4:    f24b0031    K.1.    MOV      r0,#0xb031
        0x100033d8:    f2c20000    ....    MOVT     r0,#0x2000
        0x100033dc:    2102        .!      MOVS     r1,#2
        0x100033de:    e775        u.      B        0x100032cc ; I2C_HAL_Process + 144
        0x100033e0:    f24b003c    K.<.    MOV      r0,#0xb03c
        0x100033e4:    f24b015c    K.\.    MOV      r1,#0xb05c
        0x100033e8:    f2c20000    ....    MOVT     r0,#0x2000
        0x100033ec:    f2c20100    ....    MOVT     r1,#0x2000
        0x100033f0:    6800        .h      LDR      r0,[r0,#0]
        0x100033f2:    8809        ..      LDRH     r1,[r1,#0]
        0x100033f4:    f000f916    ....    BL       i2c_arm_rx_dma ; 0x10003624
        0x100033f8:    b120         .      CBZ      r0,0x10003404 ; I2C_HAL_Process + 456
        0x100033fa:    2003        .       MOVS     r0,#3
        0x100033fc:    e8bd41f0    ...A    POP      {r4-r8,lr}
        0x10003400:    f000b940    ..@.    B.W      i2c_fail ; 0x10003684
        0x10003404:    2007        .       MOVS     r0,#7
        0x10003406:    e7d2        ..      B        0x100033ae ; I2C_HAL_Process + 370
    I2C_HAL_TakeEvent
        0x10003408:    f24b0131    K.1.    MOV      r1,#0xb031
        0x1000340c:    f2c20100    ....    MOVT     r1,#0x2000
        0x10003410:    7808        .x      LDRB     r0,[r1,#0]
        0x10003412:    2200        ."      MOVS     r2,#0
        0x10003414:    700a        .p      STRB     r2,[r1,#0]
        0x10003416:    4770        pG      BX       lr
    NMI_Handler_Proc
        0x10003418:    4614        .F      MOV      r4,r2
        0x1000341a:    460d        .F      MOV      r5,r1
        0x1000341c:    4606        .F      MOV      r6,r0
        0x1000341e:    f000f895    ....    BL       app_debug_reinit ; 0x1000354c
        0x10003422:    a005        ..      ADR      r0,{pc}+0x16 ; 0x10003438
        0x10003424:    4631        1F      MOV      r1,r6
        0x10003426:    462a        *F      MOV      r2,r5
        0x10003428:    4623        #F      MOV      r3,r4
        0x1000342a:    f000fb37    ..7.    BL       __0printf ; 0x10003a9c
        0x1000342e:    f000f85f    .._.    BL       app_debug_printf ; 0x100034f0
        0x10003432:    bf00        ..      NOP      
        0x10003434:    e7fe        ..      B        0x10003434 ; NMI_Handler_Proc + 28
        0x10003436:    bf00        ..      NOP      
    $d
        0x10003438:    5f494d4e    NMI_    DCD    1598639438
        0x1000343c:    646e6148    Hand    DCD    1684955464
        0x10003440:    3a72656c    ler:    DCD    980575596
        0x10003444:    38302520     %08    DCD    942679328
        0x10003448:    25202c58    X, %    DCD    622865496
        0x1000344c:    2c583830    08X,    DCD    743979056
        0x10003450:    38302520     %08    DCD    942679328
        0x10003454:    00000a58    X...    DCD    2648
    $t
    app_debug_init
        0x10003458:    b510        ..      PUSH     {r4,lr}
        0x1000345a:    f8ddc008    ....    LDR      r12,[sp,#8]
        0x1000345e:    f1b24fc0    ...O    CMP      r2,#0x60000000
        0x10003462:    d00b        ..      BEQ      0x1000347c ; app_debug_init + 36
        0x10003464:    f6400e00    @...    MOVW     lr,#0x800
        0x10003468:    f2c60e00    ....    MOVT     lr,#0x6000
        0x1000346c:    4572        rE      CMP      r2,lr
        0x1000346e:    d005        ..      BEQ      0x1000347c ; app_debug_init + 36
        0x10003470:    f2404e00    @..N    MOVW     lr,#0x400
        0x10003474:    f2c60e00    ....    MOVT     lr,#0x6000
        0x10003478:    4572        rE      CMP      r2,lr
        0x1000347a:    d136        6.      BNE      0x100034ea ; app_debug_init + 146
        0x1000347c:    f24b0480    K...    MOV      r4,#0xb080
        0x10003480:    f0400e80    @...    ORR      lr,r0,#0x80
        0x10003484:    f2c60404    ....    MOVT     r4,#0x6004
        0x10003488:    45a6        .E      CMP      lr,r4
        0x1000348a:    d12e        ..      BNE      0x100034ea ; app_debug_init + 146
        0x1000348c:    f24b0410    K...    MOV      r4,#0xb010
        0x10003490:    f2c20400    ....    MOVT     r4,#0x2000
        0x10003494:    f1bc0f00    ....    CMP      r12,#0
        0x10003498:    f8c4c000    ....    STR      r12,[r4,#0]
        0x1000349c:    d00d        ..      BEQ      0x100034ba ; app_debug_init + 98
        0x1000349e:    f24b0c1e    K...    MOV      r12,#0xb01e
        0x100034a2:    f24b041c    K...    MOV      r4,#0xb01c
        0x100034a6:    f2c20c00    ....    MOVT     r12,#0x2000
        0x100034aa:    f04f0e00    O...    MOV      lr,#0
        0x100034ae:    f2c20400    ....    MOVT     r4,#0x2000
        0x100034b2:    f8ace000    ....    STRH     lr,[r12,#0]
        0x100034b6:    f8a4e000    ....    STRH     lr,[r4,#0]
        0x100034ba:    f24b0418    K...    MOV      r4,#0xb018
        0x100034be:    f2c20400    ....    MOVT     r4,#0x2000
        0x100034c2:    6022        "`      STR      r2,[r4,#0]
        0x100034c4:    f24b0214    K...    MOV      r2,#0xb014
        0x100034c8:    f2c20200    ....    MOVT     r2,#0x2000
        0x100034cc:    6010        .`      STR      r0,[r2,#0]
        0x100034ce:    f24b0020    K. .    MOV      r0,#0xb020
        0x100034d2:    f2c20000    ....    MOVT     r0,#0x2000
        0x100034d6:    6001        .`      STR      r1,[r0,#0]
        0x100034d8:    f24b0024    K.$.    MOV      r0,#0xb024
        0x100034dc:    f2c20000    ....    MOVT     r0,#0x2000
        0x100034e0:    6003        .`      STR      r3,[r0,#0]
        0x100034e2:    e8bd4010    ...@    POP      {r4,lr}
        0x100034e6:    f000b831    ..1.    B.W      app_debug_reinit ; 0x1000354c
        0x100034ea:    2010        .       MOVS     r0,#0x10
        0x100034ec:    bd10        ..      POP      {r4,pc}
        0x100034ee:    0000        ..      MOVS     r0,r0
    app_debug_printf
        0x100034f0:    b5f0        ..      PUSH     {r4-r7,lr}
        0x100034f2:    b081        ..      SUB      sp,sp,#4
        0x100034f4:    f24b0410    K...    MOV      r4,#0xb010
        0x100034f8:    f2c20400    ....    MOVT     r4,#0x2000
        0x100034fc:    6820         h      LDR      r0,[r4,#0]
        0x100034fe:    b318        ..      CBZ      r0,0x10003548 ; app_debug_printf + 88
        0x10003500:    f24b051e    K...    MOV      r5,#0xb01e
        0x10003504:    f24b061c    K...    MOV      r6,#0xb01c
        0x10003508:    f2c20500    ....    MOVT     r5,#0x2000
        0x1000350c:    f2c20600    ....    MOVT     r6,#0x2000
        0x10003510:    8828        (.      LDRH     r0,[r5,#0]
        0x10003512:    8831        1.      LDRH     r1,[r6,#0]
        0x10003514:    4288        .B      CMP      r0,r1
        0x10003516:    d017        ..      BEQ      0x10003548 ; app_debug_printf + 88
        0x10003518:    f24b0718    K...    MOV      r7,#0xb018
        0x1000351c:    f2c20700    ....    MOVT     r7,#0x2000
        0x10003520:    6821        !h      LDR      r1,[r4,#0]
        0x10003522:    b282        ..      UXTH     r2,r0
        0x10003524:    6809        .h      LDR      r1,[r1,#0]
        0x10003526:    6838        8h      LDR      r0,[r7,#0]
        0x10003528:    5c89        .\      LDRB     r1,[r1,r2]
        0x1000352a:    f000fa66    ..f.    BL       $Ven$TT$L$$rom_hw_uart_send_byte ; 0x100039fa
        0x1000352e:    8828        (.      LDRH     r0,[r5,#0]
        0x10003530:    6821        !h      LDR      r1,[r4,#0]
        0x10003532:    3001        .0      ADDS     r0,#1
        0x10003534:    b282        ..      UXTH     r2,r0
        0x10003536:    8889        ..      LDRH     r1,[r1,#4]
        0x10003538:    428a        .B      CMP      r2,r1
        0x1000353a:    bf28        (.      IT       CS
        0x1000353c:    2000        .       MOVCS    r0,#0
        0x1000353e:    b281        ..      UXTH     r1,r0
        0x10003540:    8832        2.      LDRH     r2,[r6,#0]
        0x10003542:    8028        (.      STRH     r0,[r5,#0]
        0x10003544:    4291        .B      CMP      r1,r2
        0x10003546:    d1eb        ..      BNE      0x10003520 ; app_debug_printf + 48
        0x10003548:    b001        ..      ADD      sp,sp,#4
        0x1000354a:    bdf0        ..      POP      {r4-r7,pc}
    app_debug_reinit
        0x1000354c:    b5f0        ..      PUSH     {r4-r7,lr}
        0x1000354e:    b083        ..      SUB      sp,sp,#0xc
        0x10003550:    f24b0518    K...    MOV      r5,#0xb018
        0x10003554:    f2c20500    ....    MOVT     r5,#0x2000
        0x10003558:    6828        (h      LDR      r0,[r5,#0]
        0x1000355a:    f1b04fc0    ...O    CMP      r0,#0x60000000
        0x1000355e:    d00a        ..      BEQ      0x10003576 ; app_debug_reinit + 42
        0x10003560:    f2404100    @..A    MOVW     r1,#0x400
        0x10003564:    f2c60100    ....    MOVT     r1,#0x6000
        0x10003568:    4288        .B      CMP      r0,r1
        0x1000356a:    bf19        ..      ITTEE    NE
        0x1000356c:    240c        .$      MOVNE    r4,#0xc
        0x1000356e:    202d        -       MOVNE    r0,#0x2d
        0x10003570:    2408        .$      MOVEQ    r4,#8
        0x10003572:    202c        ,       MOVEQ    r0,#0x2c
        0x10003574:    e001        ..      B        0x1000357a ; app_debug_reinit + 46
        0x10003576:    2404        .$      MOVS     r4,#4
        0x10003578:    202b        +       MOVS     r0,#0x2b
        0x1000357a:    f000f9a8    ....    BL       $Ven$TT$L$$rom_hw_crg_enable_clk_gate ; 0x100038ce
        0x1000357e:    f24b0614    K...    MOV      r6,#0xb014
        0x10003582:    f24b0720    K. .    MOV      r7,#0xb020
        0x10003586:    f2c20600    ....    MOVT     r6,#0x2000
        0x1000358a:    f2c20700    ....    MOVT     r7,#0x2000
        0x1000358e:    6830        0h      LDR      r0,[r6,#0]
        0x10003590:    6839        9h      LDR      r1,[r7,#0]
        0x10003592:    4622        "F      MOV      r2,r4
        0x10003594:    f000f9d2    ....    BL       $Ven$TT$L$$rom_hw_gpio_set_pin_pid ; 0x1000393c
        0x10003598:    b108        ..      CBZ      r0,0x1000359e ; app_debug_reinit + 82
        0x1000359a:    b003        ..      ADD      sp,sp,#0xc
        0x1000359c:    bdf0        ..      POP      {r4-r7,pc}
        0x1000359e:    6830        0h      LDR      r0,[r6,#0]
        0x100035a0:    6839        9h      LDR      r1,[r7,#0]
        0x100035a2:    2202        ."      MOVS     r2,#2
        0x100035a4:    f000f9cf    ....    BL       $Ven$TT$L$$rom_hw_gpio_set_pin_pull_mode ; 0x10003946
        0x100035a8:    2800        .(      CMP      r0,#0
        0x100035aa:    d1f6        ..      BNE      0x1000359a ; app_debug_reinit + 78
        0x100035ac:    f24b0024    K.$.    MOV      r0,#0xb024
        0x100035b0:    f2c20000    ....    MOVT     r0,#0x2000
        0x100035b4:    6800        .h      LDR      r0,[r0,#0]
        0x100035b6:    f2430121    C.!.    MOV      r1,#0x3021
        0x100035ba:    9001        ..      STR      r0,[sp,#4]
        0x100035bc:    f2c01101    ....    MOVT     r1,#0x101
        0x100035c0:    6828        (h      LDR      r0,[r5,#0]
        0x100035c2:    9102        ..      STR      r1,[sp,#8]
        0x100035c4:    a901        ..      ADD      r1,sp,#4
        0x100035c6:    f000fa1d    ....    BL       $Ven$TT$L$$rom_hw_uart_init ; 0x10003a04
        0x100035ca:    b003        ..      ADD      sp,sp,#0xc
        0x100035cc:    bdf0        ..      POP      {r4-r7,pc}
        0x100035ce:    0000        ..      MOVS     r0,r0
    fputc
        0x100035d0:    b510        ..      PUSH     {r4,lr}
        0x100035d2:    b082        ..      SUB      sp,sp,#8
        0x100035d4:    f24b0110    K...    MOV      r1,#0xb010
        0x100035d8:    f2c20100    ....    MOVT     r1,#0x2000
        0x100035dc:    6809        .h      LDR      r1,[r1,#0]
        0x100035de:    b179        y.      CBZ      r1,0x10003600 ; fputc + 48
        0x100035e0:    f24b031c    K...    MOV      r3,#0xb01c
        0x100035e4:    f2c20300    ....    MOVT     r3,#0x2000
        0x100035e8:    680a        .h      LDR      r2,[r1,#0]
        0x100035ea:    881c        ..      LDRH     r4,[r3,#0]
        0x100035ec:    5510        .U      STRB     r0,[r2,r4]
        0x100035ee:    1c62        b.      ADDS     r2,r4,#1
        0x100035f0:    b294        ..      UXTH     r4,r2
        0x100035f2:    8889        ..      LDRH     r1,[r1,#4]
        0x100035f4:    428c        .B      CMP      r4,r1
        0x100035f6:    bf28        (.      IT       CS
        0x100035f8:    2200        ."      MOVCS    r2,#0
        0x100035fa:    801a        ..      STRH     r2,[r3,#0]
        0x100035fc:    b002        ..      ADD      sp,sp,#8
        0x100035fe:    bd10        ..      POP      {r4,pc}
        0x10003600:    f24b0118    K...    MOV      r1,#0xb018
        0x10003604:    f2c20100    ....    MOVT     r1,#0x2000
        0x10003608:    680a        .h      LDR      r2,[r1,#0]
        0x1000360a:    f88d0007    ....    STRB     r0,[sp,#7]
        0x1000360e:    f10d0107    ....    ADD      r1,sp,#7
        0x10003612:    4604        .F      MOV      r4,r0
        0x10003614:    4610        .F      MOV      r0,r2
        0x10003616:    2201        ."      MOVS     r2,#1
        0x10003618:    f000f9f9    ....    BL       $Ven$TT$L$$rom_hw_uart_transmit ; 0x10003a0e
        0x1000361c:    4620         F      MOV      r0,r4
        0x1000361e:    b002        ..      ADD      sp,sp,#8
        0x10003620:    bd10        ..      POP      {r4,pc}
        0x10003622:    0000        ..      MOVS     r0,r0
    i2c_arm_rx_dma
        0x10003624:    b510        ..      PUSH     {r4,lr}
        0x10003626:    f2430200    C...    MOVW     r2,#0x3000
        0x1000362a:    f2c60200    ....    MOVT     r2,#0x6000
        0x1000362e:    f2481480    H...    MOV      r4,#0x8180
        0x10003632:    f2c50400    ....    MOVT     r4,#0x5000
        0x10003636:    1d13        ..      ADDS     r3,r2,#4
        0x10003638:    6163        ca      STR      r3,[r4,#0x14]
        0x1000363a:    61a0        .a      STR      r0,[r4,#0x18]
        0x1000363c:    68e0        .h      LDR      r0,[r4,#0xc]
        0x1000363e:    f64f73ff    O..s    MOV      r3,#0xffff
        0x10003642:    4398        .C      BICS     r0,r0,r3
        0x10003644:    4408        .D      ADD      r0,r0,r1
        0x10003646:    60e0        .`      STR      r0,[r4,#0xc]
        0x10003648:    4610        .F      MOV      r0,r2
        0x1000364a:    2101        .!      MOVS     r1,#1
        0x1000364c:    f000f9b2    ....    BL       $Ven$TT$L$$rom_hw_i2c_set_rxfifo_thld ; 0x100039b4
        0x10003650:    b948        H.      CBNZ     r0,0x10003666 ; i2c_arm_rx_dma + 66
        0x10003652:    4620         F      MOV      r0,r4
        0x10003654:    213f        ?!      MOVS     r1,#0x3f
        0x10003656:    f000f9b2    ....    BL       $Ven$TT$L$$rom_hw_dma_clear_interrupt_flag ; 0x100039be
        0x1000365a:    b920         .      CBNZ     r0,0x10003666 ; i2c_arm_rx_dma + 66
        0x1000365c:    4620         F      MOV      r0,r4
        0x1000365e:    2102        .!      MOVS     r1,#2
        0x10003660:    f000f9b2    ....    BL       $Ven$TT$L$$rom_hw_dma_enable_interrupt ; 0x100039c8
        0x10003664:    b108        ..      CBZ      r0,0x1000366a ; i2c_arm_rx_dma + 70
        0x10003666:    2003        .       MOVS     r0,#3
        0x10003668:    bd10        ..      POP      {r4,pc}
        0x1000366a:    f24b0044    K.D.    MOV      r0,#0xb044
        0x1000366e:    f2c20000    ....    MOVT     r0,#0x2000
        0x10003672:    2100        .!      MOVS     r1,#0
        0x10003674:    7001        .p      STRB     r1,[r0,#0]
        0x10003676:    4620         F      MOV      r0,r4
        0x10003678:    f000f9ba    ....    BL       $Ven$TT$L$$rom_hw_dma_enable ; 0x100039f0
        0x1000367c:    2800        .(      CMP      r0,#0
        0x1000367e:    bf18        ..      IT       NE
        0x10003680:    2003        .       MOVNE    r0,#3
        0x10003682:    bd10        ..      POP      {r4,pc}
    i2c_fail
        0x10003684:    b5b0        ..      PUSH     {r4,r5,r7,lr}
        0x10003686:    f2481580    H...    MOV      r5,#0x8180
        0x1000368a:    f2c50500    ....    MOVT     r5,#0x5000
        0x1000368e:    4604        .F      MOV      r4,r0
        0x10003690:    4628        (F      MOV      r0,r5
        0x10003692:    f000f9a3    ....    BL       $Ven$TT$L$$rom_hw_dma_disable ; 0x100039dc
        0x10003696:    f1050040    ..@.    ADD      r0,r5,#0x40
        0x1000369a:    f000f99f    ....    BL       $Ven$TT$L$$rom_hw_dma_disable ; 0x100039dc
        0x1000369e:    f2430000    C...    MOVW     r0,#0x3000
        0x100036a2:    f2c60000    ....    MOVT     r0,#0x6000
        0x100036a6:    2102        .!      MOVS     r1,#2
        0x100036a8:    6481        .d      STR      r1,[r0,#0x48]
        0x100036aa:    f64f71ff    O..q    MOV      r1,#0xffff
        0x100036ae:    f000f99a    ....    BL       $Ven$TT$L$$rom_hw_i2c_clear_interrupt_flag ; 0x100039e6
        0x100036b2:    f24b0068    K.h.    MOV      r0,#0xb068
        0x100036b6:    f2c20000    ....    MOVT     r0,#0x2000
        0x100036ba:    2100        .!      MOVS     r1,#0
        0x100036bc:    7001        .p      STRB     r1,[r0,#0]
        0x100036be:    f24b0044    K.D.    MOV      r0,#0xb044
        0x100036c2:    f2c20000    ....    MOVT     r0,#0x2000
        0x100036c6:    7001        .p      STRB     r1,[r0,#0]
        0x100036c8:    f24b005f    K._.    MOV      r0,#0xb05f
        0x100036cc:    f2c20000    ....    MOVT     r0,#0x2000
        0x100036d0:    7001        .p      STRB     r1,[r0,#0]
        0x100036d2:    f24b0028    K.(.    MOV      r0,#0xb028
        0x100036d6:    f2c20000    ....    MOVT     r0,#0x2000
        0x100036da:    7001        .p      STRB     r1,[r0,#0]
        0x100036dc:    f24b0034    K.4.    MOV      r0,#0xb034
        0x100036e0:    f2c20000    ....    MOVT     r0,#0x2000
        0x100036e4:    6004        .`      STR      r4,[r0,#0]
        0x100036e6:    f24b0031    K.1.    MOV      r0,#0xb031
        0x100036ea:    f2c20000    ....    MOVT     r0,#0x2000
        0x100036ee:    2103        .!      MOVS     r1,#3
        0x100036f0:    7001        .p      STRB     r1,[r0,#0]
        0x100036f2:    bdb0        ..      POP      {r4,r5,r7,pc}
    main
        0x100036f4:    b082        ..      SUB      sp,sp,#8
        0x100036f6:    f24e0000    N...    MOVW     r0,#0xe000
        0x100036fa:    f2c60004    ....    MOVT     r0,#0x6004
        0x100036fe:    f000f98b    ....    BL       $Ven$TT$L$$rom_hw_wdt_disable ; 0x10003a18
        0x10003702:    2064        d       MOVS     r0,#0x64
        0x10003704:    f000f98d    ....    BL       $Ven$TT$L$$rom_delay_ms ; 0x10003a22
        0x10003708:    f000f8d2    ....    BL       system_power_init ; 0x100038b0
        0x1000370c:    2001        .       MOVS     r0,#1
        0x1000370e:    f000f89f    ....    BL       system_clock_init ; 0x10003850
        0x10003712:    f000f885    ....    BL       peripheral_init ; 0x10003820
        0x10003716:    a02d        -.      ADR      r0,{pc}+0xb6 ; 0x100037cc
        0x10003718:    f000fe2a    ..*.    BL       puts ; 0x10004370
        0x1000371c:    f7fffb38    ..8.    BL       I2C_HAL_MasterDMA_Init ; 0x10002d90
        0x10003720:    b118        ..      CBZ      r0,0x1000372a ; main + 54
        0x10003722:    a031        1.      ADR      r0,{pc}+0xc6 ; 0x100037e8
        0x10003724:    f000fe24    ..$.    BL       puts ; 0x10004370
        0x10003728:    e7fe        ..      B        0x10003728 ; main + 52
        0x1000372a:    f7fff88f    ....    BL       HS300X_Init ; 0x1000284c
        0x1000372e:    f7fff95b    ..[.    BL       HS300X_StartMeasurement ; 0x100029e8
        0x10003732:    b108        ..      CBZ      r0,0x10003738 ; main + 68
        0x10003734:    2600        .&      MOVS     r6,#0
        0x10003736:    e002        ..      B        0x1000373e ; main + 74
        0x10003738:    f7fffb1e    ....    BL       I2C_HAL_GetTickMs ; 0x10002d78
        0x1000373c:    4606        .F      MOV      r6,r0
        0x1000373e:    f24b0a0c    K...    MOV      r10,#0xb00c
        0x10003742:    f24b0808    K...    MOV      r8,#0xb008
        0x10003746:    2400        .$      MOVS     r4,#0
        0x10003748:    f20f09ac    ....    ADR.W    r9,{pc}+0xb0 ; 0x100037f8
        0x1000374c:    f2c20a00    ....    MOVT     r10,#0x2000
        0x10003750:    f2413b88    A..;    MOV      r11,#0x1388
        0x10003754:    f2c20800    ....    MOVT     r8,#0x2000
        0x10003758:    e003        ..      B        0x10003762 ; main + 110
        0x1000375a:    f7fffb0d    ....    BL       I2C_HAL_GetTickMs ; 0x10002d78
        0x1000375e:    4606        .F      MOV      r6,r0
        0x10003760:    bf30        0.      WFI      
        0x10003762:    f7fffd6b    ..k.    BL       I2C_HAL_Process ; 0x1000323c
        0x10003766:    f7fff89b    ....    BL       HS300X_Process ; 0x100028a0
        0x1000376a:    f7fff869    ..i.    BL       HS300X_DataReady ; 0x10002840
        0x1000376e:    b1b0        ..      CBZ      r0,0x1000379e ; main + 170
        0x10003770:    f8da0000    ....    LDR      r0,[r10,#0]
        0x10003774:    3401        .4      ADDS     r4,#1
        0x10003776:    f7fefdbb    ....    BL       __aeabi_f2d ; 0x100022f0
        0x1000377a:    4607        .F      MOV      r7,r0
        0x1000377c:    f8d80000    ....    LDR      r0,[r8,#0]
        0x10003780:    460d        .F      MOV      r5,r1
        0x10003782:    f7fefdb5    ....    BL       __aeabi_f2d ; 0x100022f0
        0x10003786:    ec410b10    A...    VMOV     d0,r0,r1
        0x1000378a:    4648        HF      MOV      r0,r9
        0x1000378c:    4621        !F      MOV      r1,r4
        0x1000378e:    ed8d0b00    ....    VSTR     d0,[sp,#0]
        0x10003792:    463a        :F      MOV      r2,r7
        0x10003794:    462b        +F      MOV      r3,r5
        0x10003796:    f000f981    ....    BL       __0printf ; 0x10003a9c
        0x1000379a:    f7fff849    ..I.    BL       HS300X_ClearDataReady ; 0x10002830
        0x1000379e:    f7fff875    ..u.    BL       HS300X_IsBusy ; 0x1000288c
        0x100037a2:    2800        .(      CMP      r0,#0
        0x100037a4:    d1dc        ..      BNE      0x10003760 ; main + 108
        0x100037a6:    f7fffae7    ....    BL       I2C_HAL_GetTickMs ; 0x10002d78
        0x100037aa:    1b80        ..      SUBS     r0,r0,r6
        0x100037ac:    4558        XE      CMP      r0,r11
        0x100037ae:    d3d7        ..      BCC      0x10003760 ; main + 108
        0x100037b0:    f7fff91a    ....    BL       HS300X_StartMeasurement ; 0x100029e8
        0x100037b4:    2800        .(      CMP      r0,#0
        0x100037b6:    d0d0        ..      BEQ      0x1000375a ; main + 102
        0x100037b8:    2803        .(      CMP      r0,#3
        0x100037ba:    d1d1        ..      BNE      0x10003760 ; main + 108
        0x100037bc:    f7fffad6    ....    BL       I2C_HAL_GetLastError ; 0x10002d6c
        0x100037c0:    4601        .F      MOV      r1,r0
        0x100037c2:    a013        ..      ADR      r0,{pc}+0x4e ; 0x10003810
        0x100037c4:    f000f96a    ..j.    BL       __0printf ; 0x10003a9c
        0x100037c8:    e7c7        ..      B        0x1000375a ; main + 102
        0x100037ca:    bf00        ..      NOP      
    $d
        0x100037cc:    30335348    HS30    DCD    808670024
        0x100037d0:    44207830    0x D    DCD    1142978608
        0x100037d4:    20617461    ata     DCD    543257697
        0x100037d8:    67676f4c    Logg    DCD    1734831948
        0x100037dc:    53207265    er S    DCD    1394635365
        0x100037e0:    74726174    tart    DCD    1953653108
        0x100037e4:    0000000d    ....    DCD    13
        0x100037e8:    4f525245    ERRO    DCD    1330795077
        0x100037ec:    32492c52    R,I2    DCD    843656274
        0x100037f0:    4e495f43    C_IN    DCD    1313431363
        0x100037f4:    000d5449    IT..    DCD    873545
        0x100037f8:    41544144    DATA    DCD    1096040772
        0x100037fc:    756c252c    ,%lu    DCD    1970021676
        0x10003800:    322e252c    ,%.2    DCD    841884972
        0x10003804:    2e252c66    f,%.    DCD    774188134
        0x10003808:    0a0d6632    2f..    DCD    168650290
        0x1000380c:    00000000    ....    DCD    0
        0x10003810:    4f525245    ERRO    DCD    1330795077
        0x10003814:    32492c52    R,I2    DCD    843656274
        0x10003818:    75252c43    C,%u    DCD    1965370435
        0x1000381c:    00000a0d    ....    DCD    2573
    $t
    peripheral_init
        0x10003820:    b510        ..      PUSH     {r4,lr}
        0x10003822:    b082        ..      SUB      sp,sp,#8
        0x10003824:    2001        .       MOVS     r0,#1
        0x10003826:    2100        .!      MOVS     r1,#0
        0x10003828:    2200        ."      MOVS     r2,#0
        0x1000382a:    2400        .$      MOVS     r4,#0
        0x1000382c:    f000f8fe    ....    BL       $Ven$TT$L$$rom_hw_sys_ctrl_peri_int_ctrl ; 0x10003a2c
        0x10003830:    f24b0000    K...    MOVW     r0,#0xb000
        0x10003834:    f2c60004    ....    MOVT     r0,#0x6004
        0x10003838:    f04f5100    O..Q    MOV      r1,#0x20000000
        0x1000383c:    f04f42c0    O..B    MOV      r2,#0x60000000
        0x10003840:    f44f33e1    O..3    MOV      r3,#0x1c200
        0x10003844:    9400        ..      STR      r4,[sp,#0]
        0x10003846:    f7fffe07    ....    BL       app_debug_init ; 0x10003458
        0x1000384a:    b002        ..      ADD      sp,sp,#8
        0x1000384c:    bd10        ..      POP      {r4,pc}
        0x1000384e:    0000        ..      MOVS     r0,r0
    system_clock_init
        0x10003850:    b510        ..      PUSH     {r4,lr}
        0x10003852:    b082        ..      SUB      sp,sp,#8
        0x10003854:    4604        .F      MOV      r4,r0
        0x10003856:    2000        .       MOVS     r0,#0
        0x10003858:    f88d0007    ....    STRB     r0,[sp,#7]
        0x1000385c:    f10d0107    ....    ADD      r1,sp,#7
        0x10003860:    200f        .       MOVS     r0,#0xf
        0x10003862:    2201        ."      MOVS     r2,#1
        0x10003864:    f000f8e7    ....    BL       $Ven$TT$L$$rom_hw_efuse_read_bytes ; 0x10003a36
        0x10003868:    f89d0007    ....    LDRB     r0,[sp,#7]
        0x1000386c:    2800        .(      CMP      r0,#0
        0x1000386e:    bf04        ..      ITT      EQ
        0x10003870:    2056        V       MOVEQ    r0,#0x56
        0x10003872:    f000f8e5    ....    BLEQ     $Ven$TT$L$$rom_hw_pmu_set_rc_hclk_tune ; 0x10003a40
        0x10003876:    f10d0107    ....    ADD      r1,sp,#7
        0x1000387a:    2010        .       MOVS     r0,#0x10
        0x1000387c:    2201        ."      MOVS     r2,#1
        0x1000387e:    f000f8da    ....    BL       $Ven$TT$L$$rom_hw_efuse_read_bytes ; 0x10003a36
        0x10003882:    f89d0007    ....    LDRB     r0,[sp,#7]
        0x10003886:    2800        .(      CMP      r0,#0
        0x10003888:    bf08        ..      IT       EQ
        0x1000388a:    20a9        .       MOVEQ    r0,#0xa9
        0x1000388c:    f000f8dd    ....    BL       $Ven$TT$L$$rom_hw_pmu_set_rc_lclk_tune ; 0x10003a4a
        0x10003890:    2000        .       MOVS     r0,#0
        0x10003892:    f000f8df    ....    BL       $Ven$TT$L$$rom_hw_pmu_sel_dcxo_hclk_pwr ; 0x10003a54
        0x10003896:    2003        .       MOVS     r0,#3
        0x10003898:    2103        .!      MOVS     r1,#3
        0x1000389a:    2264        d"      MOVS     r2,#0x64
        0x1000389c:    f000f8df    ....    BL       $Ven$TT$L$$rom_hal_pmu_cfg_dcxo_hclk_param ; 0x10003a5e
        0x100038a0:    4620         F      MOV      r0,r4
        0x100038a2:    f64011c4    @...    MOV      r1,#0x9c4
        0x100038a6:    f000f8df    ....    BL       $Ven$TT$L$$rom_hal_pmu_set_sys_clk_src ; 0x10003a68
        0x100038aa:    b002        ..      ADD      sp,sp,#8
        0x100038ac:    bd10        ..      POP      {r4,pc}
        0x100038ae:    0000        ..      MOVS     r0,r0
    system_power_init
        0x100038b0:    b580        ..      PUSH     {r7,lr}
        0x100038b2:    2002        .       MOVS     r0,#2
        0x100038b4:    f000f8dd    ....    BL       $Ven$TT$L$$rom_hw_pmu_set_ldo_act_voltage ; 0x10003a72
        0x100038b8:    2000        .       MOVS     r0,#0
        0x100038ba:    f000f8df    ....    BL       $Ven$TT$L$$rom_hw_pmu_set_ldo_dig_voltage ; 0x10003a7c
        0x100038be:    2000        .       MOVS     r0,#0
        0x100038c0:    f000f8e1    ....    BL       $Ven$TT$L$$rom_hw_pmu_set_ldo_ret_sleep_voltage ; 0x10003a86
        0x100038c4:    2000        .       MOVS     r0,#0
        0x100038c6:    e8bd4080    ...@    POP      {r7,lr}
        0x100038ca:    f000b8e1    ....    B.W      $Ven$TT$L$$rom_hal_pmu_sel_power_act_out_mode ; 0x10003a90
    $Ven$TT$L$$rom_hw_crg_enable_clk_gate
        0x100038ce:    f6471c7d    G.}.    MOV      r12,#0x797d
        0x100038d2:    f2c00c00    ....    MOVT     r12,#0
        0x100038d6:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_stim_stop
        0x100038d8:    f24c0c31    L.1.    MOV      r12,#0xc031
        0x100038dc:    f2c00c00    ....    MOVT     r12,#0
        0x100038e0:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_stim_clear_count
        0x100038e2:    f64b3c5d    K.]<    MOV      r12,#0xbb5d
        0x100038e6:    f2c00c00    ....    MOVT     r12,#0
        0x100038ea:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_stim_set_prescale
        0x100038ec:    f64b7c4d    K.M|    MOV      r12,#0xbf4d
        0x100038f0:    f2c00c00    ....    MOVT     r12,#0
        0x100038f4:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_stim_disable_interrupt
        0x100038f6:    f64b3cf1    K..<    MOV      r12,#0xbbf1
        0x100038fa:    f2c00c00    ....    MOVT     r12,#0
        0x100038fe:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_stim_clear_interrupt_flag
        0x10003900:    f64b3cd1    K..<    MOV      r12,#0xbbd1
        0x10003904:    f2c00c00    ....    MOVT     r12,#0
        0x10003908:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_sys_ctrl_enable_peri_int
        0x1000390a:    f24c1cc5    L...    MOV      r12,#0xc1c5
        0x1000390e:    f2c00c00    ....    MOVT     r12,#0
        0x10003912:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_stim_enable_interrupt
        0x10003914:    f64b4cb9    K..L    MOV      r12,#0xbcb9
        0x10003918:    f2c00c00    ....    MOVT     r12,#0
        0x1000391c:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_stim_get_count
        0x1000391e:    f64b5ca5    K..\    MOV      r12,#0xbda5
        0x10003922:    f2c00c00    ....    MOVT     r12,#0
        0x10003926:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_stim_set_compare
        0x10003928:    f64b6c65    K.el    MOV      r12,#0xbe65
        0x1000392c:    f2c00c00    ....    MOVT     r12,#0
        0x10003930:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_stim_start
        0x10003932:    f64b7cc5    K..|    MOV      r12,#0xbfc5
        0x10003936:    f2c00c00    ....    MOVT     r12,#0
        0x1000393a:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_gpio_set_pin_pid
        0x1000393c:    f6490c21    I.!.    MOV      r12,#0x9821
        0x10003940:    f2c00c00    ....    MOVT     r12,#0
        0x10003944:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_gpio_set_pin_pull_mode
        0x10003946:    f6490c9d    I...    MOV      r12,#0x989d
        0x1000394a:    f2c00c00    ....    MOVT     r12,#0
        0x1000394e:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_gpio_set_pin_input_output
        0x10003950:    f2496cf1    I..l    MOV      r12,#0x96f1
        0x10003954:    f2c00c00    ....    MOVT     r12,#0
        0x10003958:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_gpio_set_pin_drive_strength
        0x1000395a:    f2496c71    I.ql    MOV      r12,#0x9671
        0x1000395e:    f2c00c00    ....    MOVT     r12,#0
        0x10003962:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_gpio_set_pin_output_level
        0x10003964:    f2497cf9    I..|    MOV      r12,#0x97f9
        0x10003968:    f2c00c00    ....    MOVT     r12,#0
        0x1000396c:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_i2c_master_init
        0x1000396e:    f6494c9d    I..L    MOV      r12,#0x9c9d
        0x10003972:    f2c00c00    ....    MOVT     r12,#0
        0x10003976:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_dma_init
        0x10003978:    f2483c65    H.e<    MOV      r12,#0x8365
        0x1000397c:    f2c00c00    ....    MOVT     r12,#0
        0x10003980:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_dma_set_interrupt_channel
        0x10003982:    f2484cf1    H..L    MOV      r12,#0x84f1
        0x10003986:    f2c00c00    ....    MOVT     r12,#0
        0x1000398a:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_i2c_set_mode
        0x1000398c:    f24a3c2d    J.-<    MOV      r12,#0xa32d
        0x10003990:    f2c00c00    ....    MOVT     r12,#0
        0x10003994:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_i2c_master_set_trx_mode
        0x10003996:    f24a2c11    J..,    MOV      r12,#0xa211
        0x1000399a:    f2c00c00    ....    MOVT     r12,#0
        0x1000399e:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_i2c_master_enable_stretch
        0x100039a0:    f6494c7d    I.}L    MOV      r12,#0x9c7d
        0x100039a4:    f2c00c00    ....    MOVT     r12,#0
        0x100039a8:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_i2c_master_set_rxfifo_full_value
        0x100039aa:    f24a1c91    J...    MOV      r12,#0xa191
        0x100039ae:    f2c00c00    ....    MOVT     r12,#0
        0x100039b2:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_i2c_set_rxfifo_thld
        0x100039b4:    f24a3c5d    J.]<    MOV      r12,#0xa35d
        0x100039b8:    f2c00c00    ....    MOVT     r12,#0
        0x100039bc:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_dma_clear_interrupt_flag
        0x100039be:    f2480c59    H.Y.    MOV      r12,#0x8059
        0x100039c2:    f2c00c00    ....    MOVT     r12,#0
        0x100039c6:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_dma_enable_interrupt
        0x100039c8:    f2481c35    H.5.    MOV      r12,#0x8135
        0x100039cc:    f2c00c00    ....    MOVT     r12,#0
        0x100039d0:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_dma_set_interval_tx_index
        0x100039d2:    f2485c19    H..\    MOV      r12,#0x8519
        0x100039d6:    f2c00c00    ....    MOVT     r12,#0
        0x100039da:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_dma_disable
        0x100039dc:    f2480cad    H...    MOV      r12,#0x80ad
        0x100039e0:    f2c00c00    ....    MOVT     r12,#0
        0x100039e4:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_i2c_clear_interrupt_flag
        0x100039e6:    f6492c81    I..,    MOV      r12,#0x9a81
        0x100039ea:    f2c00c00    ....    MOVT     r12,#0
        0x100039ee:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_dma_enable
        0x100039f0:    f2481c15    H...    MOV      r12,#0x8115
        0x100039f4:    f2c00c00    ....    MOVT     r12,#0
        0x100039f8:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_uart_send_byte
        0x100039fa:    f64d7c7d    M.}|    MOV      r12,#0xdf7d
        0x100039fe:    f2c00c00    ....    MOVT     r12,#0
        0x10003a02:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_uart_init
        0x10003a04:    f64d6c65    M.el    MOV      r12,#0xde65
        0x10003a08:    f2c00c00    ....    MOVT     r12,#0
        0x10003a0c:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_uart_transmit
        0x10003a0e:    f24e1ccd    N...    MOV      r12,#0xe1cd
        0x10003a12:    f2c00c00    ....    MOVT     r12,#0
        0x10003a16:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_wdt_disable
        0x10003a18:    f64f0c31    O.1.    MOV      r12,#0xf831
        0x10003a1c:    f2c00c00    ....    MOVT     r12,#0
        0x10003a20:    4760        `G      BX       r12
    $Ven$TT$L$$rom_delay_ms
        0x10003a22:    f2447c71    D.q|    MOV      r12,#0x4771
        0x10003a26:    f2c00c00    ....    MOVT     r12,#0
        0x10003a2a:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_sys_ctrl_peri_int_ctrl
        0x10003a2c:    f24c3c11    L..<    MOV      r12,#0xc311
        0x10003a30:    f2c00c00    ....    MOVT     r12,#0
        0x10003a34:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_efuse_read_bytes
        0x10003a36:    f2487c0d    H..|    MOV      r12,#0x870d
        0x10003a3a:    f2c00c00    ....    MOVT     r12,#0
        0x10003a3e:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_pmu_set_rc_hclk_tune
        0x10003a40:    f64a6c59    J.Yl    MOV      r12,#0xae59
        0x10003a44:    f2c00c00    ....    MOVT     r12,#0
        0x10003a48:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_pmu_set_rc_lclk_tune
        0x10003a4a:    f64a6c69    J.il    MOV      r12,#0xae69
        0x10003a4e:    f2c00c00    ....    MOVT     r12,#0
        0x10003a52:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_pmu_sel_dcxo_hclk_pwr
        0x10003a54:    f64a3cb1    J..<    MOV      r12,#0xabb1
        0x10003a58:    f2c00c00    ....    MOVT     r12,#0
        0x10003a5c:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hal_pmu_cfg_dcxo_hclk_param
        0x10003a5e:    f6451c65    E.e.    MOV      r12,#0x5965
        0x10003a62:    f2c00c00    ....    MOVT     r12,#0
        0x10003a66:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hal_pmu_set_sys_clk_src
        0x10003a68:    f6455c29    E.)\    MOV      r12,#0x5d29
        0x10003a6c:    f2c00c00    ....    MOVT     r12,#0
        0x10003a70:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_pmu_set_ldo_act_voltage
        0x10003a72:    f64a5c7d    J.}\    MOV      r12,#0xad7d
        0x10003a76:    f2c00c00    ....    MOVT     r12,#0
        0x10003a7a:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_pmu_set_ldo_dig_voltage
        0x10003a7c:    f64a5ca9    J..\    MOV      r12,#0xada9
        0x10003a80:    f2c00c00    ....    MOVT     r12,#0
        0x10003a84:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_pmu_set_ldo_ret_sleep_voltage
        0x10003a86:    f64a5cfd    J..\    MOV      r12,#0xadfd
        0x10003a8a:    f2c00c00    ....    MOVT     r12,#0
        0x10003a8e:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hal_pmu_sel_power_act_out_mode
        0x10003a90:    f6454c21    E.!L    MOV      r12,#0x5c21
        0x10003a94:    f2c00c00    ....    MOVT     r12,#0
        0x10003a98:    4760        `G      BX       r12
        0x10003a9a:    0000        ..      MOVS     r0,r0
    i.__0printf
    __0printf
    __1printf
    __2printf
    __c89printf
    printf
        0x10003a9c:    b40f        ..      PUSH     {r0-r3}
        0x10003a9e:    4b05        .K      LDR      r3,[pc,#20] ; [0x10003ab4] = 0x100035d1
        0x10003aa0:    b510        ..      PUSH     {r4,lr}
        0x10003aa2:    a903        ..      ADD      r1,sp,#0xc
        0x10003aa4:    4a04        .J      LDR      r2,[pc,#16] ; [0x10003ab8] = 0x2000b000
        0x10003aa6:    9802        ..      LDR      r0,[sp,#8]
        0x10003aa8:    f000f8ca    ....    BL       _printf_core ; 0x10003c40
        0x10003aac:    bc10        ..      POP      {r4}
        0x10003aae:    f85dfb14    ]...    LDR      pc,[sp],#0x14
    $d
        0x10003ab2:    0000        ..      DCW    0
        0x10003ab4:    100035d1    .5..    DCD    268449233
        0x10003ab8:    2000b000    ...     DCD    536915968
    $t
    i._fp_digits
    _fp_digits
        0x10003abc:    e92d5fff    -.._    PUSH     {r0-r12,lr}
        0x10003ac0:    b082        ..      SUB      sp,sp,#8
        0x10003ac2:    2100        .!      MOVS     r1,#0
        0x10003ac4:    e9dd3004    ...0    LDRD     r3,r0,[sp,#0x10]
        0x10003ac8:    0d02        ..      LSRS     r2,r0,#20
        0x10003aca:    f8ddb040    ..@.    LDR      r11,[sp,#0x40]
        0x10003ace:    4303        .C      ORRS     r3,r3,r0
        0x10003ad0:    d018        ..      BEQ      0x10003b04 ; _fp_digits + 72
        0x10003ad2:    f6445010    D..P    MOV      r0,#0x4d10
        0x10003ad6:    f2a232ff    ...2    SUB      r2,r2,#0x3ff
        0x10003ada:    4342        BC      MULS     r2,r0,r2
        0x10003adc:    1415        ..      ASRS     r5,r2,#16
        0x10003ade:    9811        ..      LDR      r0,[sp,#0x44]
        0x10003ae0:    2801        .(      CMP      r0,#1
        0x10003ae2:    d01f        ..      BEQ      0x10003b24 ; _fp_digits + 104
        0x10003ae4:    eba5000b    ....    SUB      r0,r5,r11
        0x10003ae8:    1c40        @.      ADDS     r0,r0,#1
        0x10003aea:    ea5f0a00    _...    MOVS     r10,r0
        0x10003aee:    f04f0600    O...    MOV      r6,#0
        0x10003af2:    4f4e        NO      LDR      r7,[pc,#312] ; [0x10003c2c] = 0x40140000
        0x10003af4:    f8df9138    ..8.    LDR      r9,[pc,#312] ; [0x10003c30] = 0x3ff00000
        0x10003af8:    46b0        .F      MOV      r8,r6
        0x10003afa:    4650        PF      MOV      r0,r10
        0x10003afc:    d515        ..      BPL      0x10003b2a ; _fp_digits + 110
        0x10003afe:    f1ca0400    ....    RSB      r4,r10,#0
        0x10003b02:    e013        ..      B        0x10003b2c ; _fp_digits + 112
        0x10003b04:    9811        ..      LDR      r0,[sp,#0x44]
        0x10003b06:    2401        .$      MOVS     r4,#1
        0x10003b08:    a34a        J.      ADR      r3,{pc}+0x12c ; 0x10003c34
        0x10003b0a:    2801        .(      CMP      r0,#1
        0x10003b0c:    d101        ..      BNE      0x10003b12 ; _fp_digits + 86
        0x10003b0e:    ea6f010b    o...    MVN      r1,r11
        0x10003b12:    9802        ..      LDR      r0,[sp,#8]
        0x10003b14:    9a11        ..      LDR      r2,[sp,#0x44]
        0x10003b16:    e9c03100    ...1    STRD     r3,r1,[r0,#0]
        0x10003b1a:    e9c04202    ...B    STRD     r4,r2,[r0,#8]
        0x10003b1e:    b006        ..      ADD      sp,sp,#0x18
        0x10003b20:    e8bd9ff0    ....    POP      {r4-r12,pc}
        0x10003b24:    f1cb0000    ....    RSB      r0,r11,#0
        0x10003b28:    e7df        ..      B        0x10003aea ; _fp_digits + 46
        0x10003b2a:    4604        .F      MOV      r4,r0
        0x10003b2c:    2100        .!      MOVS     r1,#0
        0x10003b2e:    4a40        @J      LDR      r2,[pc,#256] ; [0x10003c30] = 0x3ff00000
        0x10003b30:    1849        I.      ADDS     r1,r1,r1
        0x10003b32:    eb425004    B..P    ADC      r0,r2,r4,LSL #20
        0x10003b36:    e9cd1000    ....    STRD     r1,r0,[sp,#0]
        0x10003b3a:    e012        ..      B        0x10003b62 ; _fp_digits + 166
        0x10003b3c:    07e0        ..      LSLS     r0,r4,#31
        0x10003b3e:    d007        ..      BEQ      0x10003b50 ; _fp_digits + 148
        0x10003b40:    4632        2F      MOV      r2,r6
        0x10003b42:    463b        ;F      MOV      r3,r7
        0x10003b44:    4640        @F      MOV      r0,r8
        0x10003b46:    4649        IF      MOV      r1,r9
        0x10003b48:    f7fefcd3    ....    BL       __aeabi_dmul ; 0x100024f2
        0x10003b4c:    4680        .F      MOV      r8,r0
        0x10003b4e:    4689        .F      MOV      r9,r1
        0x10003b50:    4632        2F      MOV      r2,r6
        0x10003b52:    463b        ;F      MOV      r3,r7
        0x10003b54:    4610        .F      MOV      r0,r2
        0x10003b56:    4619        .F      MOV      r1,r3
        0x10003b58:    f7fefccb    ....    BL       __aeabi_dmul ; 0x100024f2
        0x10003b5c:    4606        .F      MOV      r6,r0
        0x10003b5e:    460f        .F      MOV      r7,r1
        0x10003b60:    1064        d.      ASRS     r4,r4,#1
        0x10003b62:    2c00        .,      CMP      r4,#0
        0x10003b64:    d1ea        ..      BNE      0x10003b3c ; _fp_digits + 128
        0x10003b66:    e9dd0104    ....    LDRD     r0,r1,[sp,#0x10]
        0x10003b6a:    e9dd2300    ...#    LDRD     r2,r3,[sp,#0]
        0x10003b6e:    f1ba0f00    ....    CMP      r10,#0
        0x10003b72:    da06        ..      BGE      0x10003b82 ; _fp_digits + 198
        0x10003b74:    f7fefcbd    ....    BL       __aeabi_dmul ; 0x100024f2
        0x10003b78:    4642        BF      MOV      r2,r8
        0x10003b7a:    464b        KF      MOV      r3,r9
        0x10003b7c:    f7fefcb9    ....    BL       __aeabi_dmul ; 0x100024f2
        0x10003b80:    e005        ..      B        0x10003b8e ; _fp_digits + 210
        0x10003b82:    f7fefd28    ..(.    BL       __aeabi_ddiv ; 0x100025d6
        0x10003b86:    4642        BF      MOV      r2,r8
        0x10003b88:    464b        KF      MOV      r3,r9
        0x10003b8a:    f7fefd24    ..$.    BL       __aeabi_ddiv ; 0x100025d6
        0x10003b8e:    4604        .F      MOV      r4,r0
        0x10003b90:    460e        .F      MOV      r6,r1
        0x10003b92:    2200        ."      MOVS     r2,#0
        0x10003b94:    4b28        (K      LDR      r3,[pc,#160] ; [0x10003c38] = 0x43f00000
        0x10003b96:    f7fefda5    ....    BL       __aeabi_cdrcmple ; 0x100026e4
        0x10003b9a:    d803        ..      BHI      0x10003ba4 ; _fp_digits + 232
        0x10003b9c:    f04f30ff    O..0    MOV      r0,#0xffffffff
        0x10003ba0:    4601        .F      MOV      r1,r0
        0x10003ba2:    e007        ..      B        0x10003bb4 ; _fp_digits + 248
        0x10003ba4:    2200        ."      MOVS     r2,#0
        0x10003ba6:    4b25        %K      LDR      r3,[pc,#148] ; [0x10003c3c] = 0x3fe00000
        0x10003ba8:    4620         F      MOV      r0,r4
        0x10003baa:    4631        1F      MOV      r1,r6
        0x10003bac:    f7fefbfa    ....    BL       __I$use$fp ; 0x100023a4
        0x10003bb0:    f7fefd80    ....    BL       __aeabi_d2ulz ; 0x100026b4
        0x10003bb4:    2410        .$      MOVS     r4,#0x10
        0x10003bb6:    e009        ..      B        0x10003bcc ; _fp_digits + 272
        0x10003bb8:    2c00        .,      CMP      r4,#0
        0x10003bba:    db0a        ..      BLT      0x10003bd2 ; _fp_digits + 278
        0x10003bbc:    220a        ."      MOVS     r2,#0xa
        0x10003bbe:    2300        .#      MOVS     r3,#0
        0x10003bc0:    f7fefbbf    ....    BL       __aeabi_uldivmod ; 0x10002342
        0x10003bc4:    9b03        ..      LDR      r3,[sp,#0xc]
        0x10003bc6:    3230        02      ADDS     r2,r2,#0x30
        0x10003bc8:    551a        .U      STRB     r2,[r3,r4]
        0x10003bca:    1e64        d.      SUBS     r4,r4,#1
        0x10003bcc:    ea500201    P...    ORRS     r2,r0,r1
        0x10003bd0:    d1f2        ..      BNE      0x10003bb8 ; _fp_digits + 252
        0x10003bd2:    1c64        d.      ADDS     r4,r4,#1
        0x10003bd4:    9a03        ..      LDR      r2,[sp,#0xc]
        0x10003bd6:    f1c40311    ....    RSB      r3,r4,#0x11
        0x10003bda:    4414        .D      ADD      r4,r4,r2
        0x10003bdc:    9a11        ..      LDR      r2,[sp,#0x44]
        0x10003bde:    2a01        .*      CMP      r2,#1
        0x10003be0:    d003        ..      BEQ      0x10003bea ; _fp_digits + 302
        0x10003be2:    2201        ."      MOVS     r2,#1
        0x10003be4:    4308        .C      ORRS     r0,r0,r1
        0x10003be6:    d10d        ..      BNE      0x10003c04 ; _fp_digits + 328
        0x10003be8:    e00a        ..      B        0x10003c00 ; _fp_digits + 324
        0x10003bea:    4308        .C      ORRS     r0,r0,r1
        0x10003bec:    d004        ..      BEQ      0x10003bf8 ; _fp_digits + 316
        0x10003bee:    2000        .       MOVS     r0,#0
        0x10003bf0:    f04f0b11    O...    MOV      r11,#0x11
        0x10003bf4:    9011        ..      STR      r0,[sp,#0x44]
        0x10003bf6:    e772        r.      B        0x10003ade ; _fp_digits + 34
        0x10003bf8:    eba3050b    ....    SUB      r5,r3,r11
        0x10003bfc:    1e6d        m.      SUBS     r5,r5,#1
        0x10003bfe:    e00d        ..      B        0x10003c1c ; _fp_digits + 352
        0x10003c00:    455b        [E      CMP      r3,r11
        0x10003c02:    dd04        ..      BLE      0x10003c0e ; _fp_digits + 338
        0x10003c04:    f04f0200    O...    MOV      r2,#0
        0x10003c08:    f1050501    ....    ADD      r5,r5,#1
        0x10003c0c:    e004        ..      B        0x10003c18 ; _fp_digits + 348
        0x10003c0e:    da03        ..      BGE      0x10003c18 ; _fp_digits + 348
        0x10003c10:    f04f0200    O...    MOV      r2,#0
        0x10003c14:    f1a50501    ....    SUB      r5,r5,#1
        0x10003c18:    2a00        .*      CMP      r2,#0
        0x10003c1a:    d0ec        ..      BEQ      0x10003bf6 ; _fp_digits + 314
        0x10003c1c:    9802        ..      LDR      r0,[sp,#8]
        0x10003c1e:    9911        ..      LDR      r1,[sp,#0x44]
        0x10003c20:    e9c03102    ...1    STRD     r3,r1,[r0,#8]
        0x10003c24:    e9c04500    ...E    STRD     r4,r5,[r0,#0]
        0x10003c28:    e779        y.      B        0x10003b1e ; _fp_digits + 98
    $d
        0x10003c2a:    0000        ..      DCW    0
        0x10003c2c:    40140000    ...@    DCD    1075052544
        0x10003c30:    3ff00000    ...?    DCD    1072693248
        0x10003c34:    00000030    0...    DCD    48
        0x10003c38:    43f00000    ...C    DCD    1139802112
        0x10003c3c:    3fe00000    ...?    DCD    1071644672
    $t
    i._printf_core
    _printf_core
        0x10003c40:    e92d4fff    -..O    PUSH     {r0-r11,lr}
        0x10003c44:    b095        ..      SUB      sp,sp,#0x54
        0x10003c46:    469b        .F      MOV      r11,r3
        0x10003c48:    4689        .F      MOV      r9,r1
        0x10003c4a:    4606        .F      MOV      r6,r0
        0x10003c4c:    2500        .%      MOVS     r5,#0
        0x10003c4e:    e20f        ..      B        0x10004070 ; _printf_core + 1072
        0x10003c50:    2825        %(      CMP      r0,#0x25
        0x10003c52:    d177        w.      BNE      0x10003d44 ; _printf_core + 260
        0x10003c54:    2400        .$      MOVS     r4,#0
        0x10003c56:    4627        'F      MOV      r7,r4
        0x10003c58:    4af8        .J      LDR      r2,[pc,#992] ; [0x1000403c] = 0x12809
        0x10003c5a:    2101        .!      MOVS     r1,#1
        0x10003c5c:    9405        ..      STR      r4,[sp,#0x14]
        0x10003c5e:    e000        ..      B        0x10003c62 ; _printf_core + 34
        0x10003c60:    4304        .C      ORRS     r4,r4,r0
        0x10003c62:    f8163f01    ...?    LDRB     r3,[r6,#1]!
        0x10003c66:    3b20         ;      SUBS     r3,r3,#0x20
        0x10003c68:    fa01f003    ....    LSL      r0,r1,r3
        0x10003c6c:    4210        .B      TST      r0,r2
        0x10003c6e:    d1f7        ..      BNE      0x10003c60 ; _printf_core + 32
        0x10003c70:    7830        0x      LDRB     r0,[r6,#0]
        0x10003c72:    282a        *(      CMP      r0,#0x2a
        0x10003c74:    d011        ..      BEQ      0x10003c9a ; _printf_core + 90
        0x10003c76:    f06f032f    o./.    MVN      r3,#0x2f
        0x10003c7a:    7830        0x      LDRB     r0,[r6,#0]
        0x10003c7c:    f1a00230    ..0.    SUB      r2,r0,#0x30
        0x10003c80:    2a09        .*      CMP      r2,#9
        0x10003c82:    d816        ..      BHI      0x10003cb2 ; _printf_core + 114
        0x10003c84:    9a05        ..      LDR      r2,[sp,#0x14]
        0x10003c86:    f0440402    D...    ORR      r4,r4,#2
        0x10003c8a:    eb020282    ....    ADD      r2,r2,r2,LSL #2
        0x10003c8e:    eb030242    ..B.    ADD      r2,r3,r2,LSL #1
        0x10003c92:    4410        .D      ADD      r0,r0,r2
        0x10003c94:    1c76        v.      ADDS     r6,r6,#1
        0x10003c96:    9005        ..      STR      r0,[sp,#0x14]
        0x10003c98:    e7ef        ..      B        0x10003c7a ; _printf_core + 58
        0x10003c9a:    f8592b04    Y..+    LDR      r2,[r9],#4
        0x10003c9e:    9205        ..      STR      r2,[sp,#0x14]
        0x10003ca0:    2a00        .*      CMP      r2,#0
        0x10003ca2:    da03        ..      BGE      0x10003cac ; _printf_core + 108
        0x10003ca4:    4250        PB      RSBS     r0,r2,#0
        0x10003ca6:    f4445400    D..T    ORR      r4,r4,#0x2000
        0x10003caa:    9005        ..      STR      r0,[sp,#0x14]
        0x10003cac:    f0440402    D...    ORR      r4,r4,#2
        0x10003cb0:    1c76        v.      ADDS     r6,r6,#1
        0x10003cb2:    7830        0x      LDRB     r0,[r6,#0]
        0x10003cb4:    282e        .(      CMP      r0,#0x2e
        0x10003cb6:    d116        ..      BNE      0x10003ce6 ; _printf_core + 166
        0x10003cb8:    f8160f01    ....    LDRB     r0,[r6,#1]!
        0x10003cbc:    f0440404    D...    ORR      r4,r4,#4
        0x10003cc0:    282a        *(      CMP      r0,#0x2a
        0x10003cc2:    d00d        ..      BEQ      0x10003ce0 ; _printf_core + 160
        0x10003cc4:    f06f022f    o./.    MVN      r2,#0x2f
        0x10003cc8:    7830        0x      LDRB     r0,[r6,#0]
        0x10003cca:    f1a00330    ..0.    SUB      r3,r0,#0x30
        0x10003cce:    2b09        .+      CMP      r3,#9
        0x10003cd0:    d809        ..      BHI      0x10003ce6 ; _printf_core + 166
        0x10003cd2:    eb070387    ....    ADD      r3,r7,r7,LSL #2
        0x10003cd6:    eb020343    ..C.    ADD      r3,r2,r3,LSL #1
        0x10003cda:    18c7        ..      ADDS     r7,r0,r3
        0x10003cdc:    1c76        v.      ADDS     r6,r6,#1
        0x10003cde:    e7f3        ..      B        0x10003cc8 ; _printf_core + 136
        0x10003ce0:    f8597b04    Y..{    LDR      r7,[r9],#4
        0x10003ce4:    1c76        v.      ADDS     r6,r6,#1
        0x10003ce6:    7830        0x      LDRB     r0,[r6,#0]
        0x10003ce8:    286c        l(      CMP      r0,#0x6c
        0x10003cea:    d00f        ..      BEQ      0x10003d0c ; _printf_core + 204
        0x10003cec:    dc06        ..      BGT      0x10003cfc ; _printf_core + 188
        0x10003cee:    284c        L(      CMP      r0,#0x4c
        0x10003cf0:    d017        ..      BEQ      0x10003d22 ; _printf_core + 226
        0x10003cf2:    2868        h(      CMP      r0,#0x68
        0x10003cf4:    d00d        ..      BEQ      0x10003d12 ; _printf_core + 210
        0x10003cf6:    286a        j(      CMP      r0,#0x6a
        0x10003cf8:    d114        ..      BNE      0x10003d24 ; _printf_core + 228
        0x10003cfa:    e004        ..      B        0x10003d06 ; _printf_core + 198
        0x10003cfc:    2874        t(      CMP      r0,#0x74
        0x10003cfe:    d010        ..      BEQ      0x10003d22 ; _printf_core + 226
        0x10003d00:    287a        z(      CMP      r0,#0x7a
        0x10003d02:    d10f        ..      BNE      0x10003d24 ; _printf_core + 228
        0x10003d04:    e00d        ..      B        0x10003d22 ; _printf_core + 226
        0x10003d06:    f4441400    D...    ORR      r4,r4,#0x200000
        0x10003d0a:    e00a        ..      B        0x10003d22 ; _printf_core + 226
        0x10003d0c:    f4441480    D...    ORR      r4,r4,#0x100000
        0x10003d10:    e001        ..      B        0x10003d16 ; _printf_core + 214
        0x10003d12:    f4441440    D.@.    ORR      r4,r4,#0x300000
        0x10003d16:    7872        rx      LDRB     r2,[r6,#1]
        0x10003d18:    4282        .B      CMP      r2,r0
        0x10003d1a:    d102        ..      BNE      0x10003d22 ; _printf_core + 226
        0x10003d1c:    f5041480    ....    ADD      r4,r4,#0x100000
        0x10003d20:    1c76        v.      ADDS     r6,r6,#1
        0x10003d22:    1c76        v.      ADDS     r6,r6,#1
        0x10003d24:    7830        0x      LDRB     r0,[r6,#0]
        0x10003d26:    2866        f(      CMP      r0,#0x66
        0x10003d28:    d00b        ..      BEQ      0x10003d42 ; _printf_core + 258
        0x10003d2a:    dc13        ..      BGT      0x10003d54 ; _printf_core + 276
        0x10003d2c:    2858        X(      CMP      r0,#0x58
        0x10003d2e:    d077        w.      BEQ      0x10003e20 ; _printf_core + 480
        0x10003d30:    dc09        ..      BGT      0x10003d46 ; _printf_core + 262
        0x10003d32:    2800        .(      CMP      r0,#0
        0x10003d34:    d075        u.      BEQ      0x10003e22 ; _printf_core + 482
        0x10003d36:    2845        E(      CMP      r0,#0x45
        0x10003d38:    d0f6        ..      BEQ      0x10003d28 ; _printf_core + 232
        0x10003d3a:    2846        F(      CMP      r0,#0x46
        0x10003d3c:    d0f4        ..      BEQ      0x10003d28 ; _printf_core + 232
        0x10003d3e:    2847        G(      CMP      r0,#0x47
        0x10003d40:    d11a        ..      BNE      0x10003d78 ; _printf_core + 312
        0x10003d42:    e19d        ..      B        0x10004080 ; _printf_core + 1088
        0x10003d44:    e018        ..      B        0x10003d78 ; _printf_core + 312
        0x10003d46:    2863        c(      CMP      r0,#0x63
        0x10003d48:    d035        5.      BEQ      0x10003db6 ; _printf_core + 374
        0x10003d4a:    2864        d(      CMP      r0,#0x64
        0x10003d4c:    d079        y.      BEQ      0x10003e42 ; _printf_core + 514
        0x10003d4e:    2865        e(      CMP      r0,#0x65
        0x10003d50:    d112        ..      BNE      0x10003d78 ; _printf_core + 312
        0x10003d52:    e195        ..      B        0x10004080 ; _printf_core + 1088
        0x10003d54:    2870        p(      CMP      r0,#0x70
        0x10003d56:    d073        s.      BEQ      0x10003e40 ; _printf_core + 512
        0x10003d58:    dc08        ..      BGT      0x10003d6c ; _printf_core + 300
        0x10003d5a:    2867        g(      CMP      r0,#0x67
        0x10003d5c:    d0f1        ..      BEQ      0x10003d42 ; _printf_core + 258
        0x10003d5e:    2869        i(      CMP      r0,#0x69
        0x10003d60:    d06f        o.      BEQ      0x10003e42 ; _printf_core + 514
        0x10003d62:    286e        n(      CMP      r0,#0x6e
        0x10003d64:    d00d        ..      BEQ      0x10003d82 ; _printf_core + 322
        0x10003d66:    286f        o(      CMP      r0,#0x6f
        0x10003d68:    d106        ..      BNE      0x10003d78 ; _printf_core + 312
        0x10003d6a:    e0b5        ..      B        0x10003ed8 ; _printf_core + 664
        0x10003d6c:    2873        s(      CMP      r0,#0x73
        0x10003d6e:    d02c        ,.      BEQ      0x10003dca ; _printf_core + 394
        0x10003d70:    2875        u(      CMP      r0,#0x75
        0x10003d72:    d075        u.      BEQ      0x10003e60 ; _printf_core + 544
        0x10003d74:    2878        x(      CMP      r0,#0x78
        0x10003d76:    d074        t.      BEQ      0x10003e62 ; _printf_core + 546
        0x10003d78:    465a        ZF      MOV      r2,r11
        0x10003d7a:    9917        ..      LDR      r1,[sp,#0x5c]
        0x10003d7c:    4790        .G      BLX      r2
        0x10003d7e:    1c6d        m.      ADDS     r5,r5,#1
        0x10003d80:    e175        u.      B        0x1000406e ; _printf_core + 1070
        0x10003d82:    f3c45002    ...P    UBFX     r0,r4,#20,#3
        0x10003d86:    2802        .(      CMP      r0,#2
        0x10003d88:    d009        ..      BEQ      0x10003d9e ; _printf_core + 350
        0x10003d8a:    2803        .(      CMP      r0,#3
        0x10003d8c:    d00d        ..      BEQ      0x10003daa ; _printf_core + 362
        0x10003d8e:    f8d91000    ....    LDR      r1,[r9,#0]
        0x10003d92:    2804        .(      CMP      r0,#4
        0x10003d94:    d00d        ..      BEQ      0x10003db2 ; _printf_core + 370
        0x10003d96:    600d        .`      STR      r5,[r1,#0]
        0x10003d98:    f1090904    ....    ADD      r9,r9,#4
        0x10003d9c:    e167        g.      B        0x1000406e ; _printf_core + 1070
        0x10003d9e:    f8d91000    ....    LDR      r1,[r9,#0]
        0x10003da2:    17ea        ..      ASRS     r2,r5,#31
        0x10003da4:    e9c15200    ...R    STRD     r5,r2,[r1,#0]
        0x10003da8:    e7f6        ..      B        0x10003d98 ; _printf_core + 344
        0x10003daa:    f8d91000    ....    LDR      r1,[r9,#0]
        0x10003dae:    800d        ..      STRH     r5,[r1,#0]
        0x10003db0:    e7f2        ..      B        0x10003d98 ; _printf_core + 344
        0x10003db2:    700d        .p      STRB     r5,[r1,#0]
        0x10003db4:    e7f0        ..      B        0x10003d98 ; _printf_core + 344
        0x10003db6:    f8191b04    ....    LDRB     r1,[r9],#4
        0x10003dba:    f88d1000    ....    STRB     r1,[sp,#0]
        0x10003dbe:    2000        .       MOVS     r0,#0
        0x10003dc0:    f88d0001    ....    STRB     r0,[sp,#1]
        0x10003dc4:    46ea        .F      MOV      r10,sp
        0x10003dc6:    2001        .       MOVS     r0,#1
        0x10003dc8:    e003        ..      B        0x10003dd2 ; _printf_core + 402
        0x10003dca:    f859ab04    Y...    LDR      r10,[r9],#4
        0x10003dce:    f04f30ff    O..0    MOV      r0,#0xffffffff
        0x10003dd2:    0761        a.      LSLS     r1,r4,#29
        0x10003dd4:    f04f0100    O...    MOV      r1,#0
        0x10003dd8:    d402        ..      BMI      0x10003de0 ; _printf_core + 416
        0x10003dda:    e00d        ..      B        0x10003df8 ; _printf_core + 440
        0x10003ddc:    f1080101    ....    ADD      r1,r8,#1
        0x10003de0:    4688        .F      MOV      r8,r1
        0x10003de2:    42b9        .B      CMP      r1,r7
        0x10003de4:    da0f        ..      BGE      0x10003e06 ; _printf_core + 454
        0x10003de6:    4580        .E      CMP      r8,r0
        0x10003de8:    dbf8        ..      BLT      0x10003ddc ; _printf_core + 412
        0x10003dea:    f81a1008    ....    LDRB     r1,[r10,r8]
        0x10003dee:    2900        .)      CMP      r1,#0
        0x10003df0:    d1f4        ..      BNE      0x10003ddc ; _printf_core + 412
        0x10003df2:    e008        ..      B        0x10003e06 ; _printf_core + 454
        0x10003df4:    f1080101    ....    ADD      r1,r8,#1
        0x10003df8:    4688        .F      MOV      r8,r1
        0x10003dfa:    4281        .B      CMP      r1,r0
        0x10003dfc:    dbfa        ..      BLT      0x10003df4 ; _printf_core + 436
        0x10003dfe:    f81a1008    ....    LDRB     r1,[r10,r8]
        0x10003e02:    2900        .)      CMP      r1,#0
        0x10003e04:    d1f6        ..      BNE      0x10003df4 ; _printf_core + 436
        0x10003e06:    9805        ..      LDR      r0,[sp,#0x14]
        0x10003e08:    465b        [F      MOV      r3,r11
        0x10003e0a:    eba00708    ....    SUB      r7,r0,r8
        0x10003e0e:    4621        !F      MOV      r1,r4
        0x10003e10:    4638        8F      MOV      r0,r7
        0x10003e12:    9a17        ..      LDR      r2,[sp,#0x5c]
        0x10003e14:    f000fa94    ....    BL       _printf_pre_padding ; 0x10004340
        0x10003e18:    4428        (D      ADD      r0,r0,r5
        0x10003e1a:    eb000508    ....    ADD      r5,r0,r8
        0x10003e1e:    e007        ..      B        0x10003e30 ; _printf_core + 496
        0x10003e20:    e04d        M.      B        0x10003ebe ; _printf_core + 638
        0x10003e22:    e129        ).      B        0x10004078 ; _printf_core + 1080
        0x10003e24:    e00d        ..      B        0x10003e42 ; _printf_core + 514
        0x10003e26:    f81a0b01    ....    LDRB     r0,[r10],#1
        0x10003e2a:    465a        ZF      MOV      r2,r11
        0x10003e2c:    9917        ..      LDR      r1,[sp,#0x5c]
        0x10003e2e:    4790        .G      BLX      r2
        0x10003e30:    f1b80801    ....    SUBS     r8,r8,#1
        0x10003e34:    d2f7        ..      BCS      0x10003e26 ; _printf_core + 486
        0x10003e36:    465b        [F      MOV      r3,r11
        0x10003e38:    4621        !F      MOV      r1,r4
        0x10003e3a:    4638        8F      MOV      r0,r7
        0x10003e3c:    9a17        ..      LDR      r2,[sp,#0x5c]
        0x10003e3e:    e113        ..      B        0x10004068 ; _printf_core + 1064
        0x10003e40:    e042        B.      B        0x10003ec8 ; _printf_core + 648
        0x10003e42:    220a        ."      MOVS     r2,#0xa
        0x10003e44:    9200        ..      STR      r2,[sp,#0]
        0x10003e46:    f3c45202    ...R    UBFX     r2,r4,#20,#3
        0x10003e4a:    f04f0a00    O...    MOV      r10,#0
        0x10003e4e:    2a02        .*      CMP      r2,#2
        0x10003e50:    d008        ..      BEQ      0x10003e64 ; _printf_core + 548
        0x10003e52:    f859cb04    Y...    LDR      r12,[r9],#4
        0x10003e56:    2a03        .*      CMP      r2,#3
        0x10003e58:    ea4f71ec    O..q    ASR      r1,r12,#31
        0x10003e5c:    d00a        ..      BEQ      0x10003e74 ; _printf_core + 564
        0x10003e5e:    e00d        ..      B        0x10003e7c ; _printf_core + 572
        0x10003e60:    e029        ).      B        0x10003eb6 ; _printf_core + 630
        0x10003e62:    e02a        *.      B        0x10003eba ; _printf_core + 634
        0x10003e64:    f1090107    ....    ADD      r1,r9,#7
        0x10003e68:    f0210207    !...    BIC      r2,r1,#7
        0x10003e6c:    e8f2c102    ....    LDRD     r12,r1,[r2],#8
        0x10003e70:    4691        .F      MOV      r9,r2
        0x10003e72:    e009        ..      B        0x10003e88 ; _printf_core + 584
        0x10003e74:    fa0ffc8c    ....    SXTH     r12,r12
        0x10003e78:    ea4f71ec    O..q    ASR      r1,r12,#31
        0x10003e7c:    2a04        .*      CMP      r2,#4
        0x10003e7e:    d103        ..      BNE      0x10003e88 ; _printf_core + 584
        0x10003e80:    fa4ffc8c    O...    SXTB     r12,r12
        0x10003e84:    ea4f71ec    O..q    ASR      r1,r12,#31
        0x10003e88:    2900        .)      CMP      r1,#0
        0x10003e8a:    da07        ..      BGE      0x10003e9c ; _printf_core + 604
        0x10003e8c:    460a        .F      MOV      r2,r1
        0x10003e8e:    2100        .!      MOVS     r1,#0
        0x10003e90:    f1dc0c00    ....    RSBS     r12,r12,#0
        0x10003e94:    eb610102    a...    SBC      r1,r1,r2
        0x10003e98:    222d        -"      MOVS     r2,#0x2d
        0x10003e9a:    e002        ..      B        0x10003ea2 ; _printf_core + 610
        0x10003e9c:    0522        ".      LSLS     r2,r4,#20
        0x10003e9e:    d504        ..      BPL      0x10003eaa ; _printf_core + 618
        0x10003ea0:    222b        +"      MOVS     r2,#0x2b
        0x10003ea2:    f88d2004    ...     STRB     r2,[sp,#4]
        0x10003ea6:    2201        ."      MOVS     r2,#1
        0x10003ea8:    e003        ..      B        0x10003eb2 ; _printf_core + 626
        0x10003eaa:    07e2        ..      LSLS     r2,r4,#31
        0x10003eac:    d001        ..      BEQ      0x10003eb2 ; _printf_core + 626
        0x10003eae:    2220         "      MOVS     r2,#0x20
        0x10003eb0:    e7f7        ..      B        0x10003ea2 ; _printf_core + 610
        0x10003eb2:    4690        .F      MOV      r8,r2
        0x10003eb4:    e059        Y.      B        0x10003f6a ; _printf_core + 810
        0x10003eb6:    210a        .!      MOVS     r1,#0xa
        0x10003eb8:    e002        ..      B        0x10003ec0 ; _printf_core + 640
        0x10003eba:    2210        ."      MOVS     r2,#0x10
        0x10003ebc:    e00d        ..      B        0x10003eda ; _printf_core + 666
        0x10003ebe:    2110        .!      MOVS     r1,#0x10
        0x10003ec0:    f04f0a00    O...    MOV      r10,#0
        0x10003ec4:    9100        ..      STR      r1,[sp,#0]
        0x10003ec6:    e00b        ..      B        0x10003ee0 ; _printf_core + 672
        0x10003ec8:    2210        ."      MOVS     r2,#0x10
        0x10003eca:    f04f0a00    O...    MOV      r10,#0
        0x10003ece:    f0440404    D...    ORR      r4,r4,#4
        0x10003ed2:    2708        .'      MOVS     r7,#8
        0x10003ed4:    9200        ..      STR      r2,[sp,#0]
        0x10003ed6:    e003        ..      B        0x10003ee0 ; _printf_core + 672
        0x10003ed8:    2208        ."      MOVS     r2,#8
        0x10003eda:    f04f0a00    O...    MOV      r10,#0
        0x10003ede:    9200        ..      STR      r2,[sp,#0]
        0x10003ee0:    f3c45202    ...R    UBFX     r2,r4,#20,#3
        0x10003ee4:    2a02        .*      CMP      r2,#2
        0x10003ee6:    d005        ..      BEQ      0x10003ef4 ; _printf_core + 692
        0x10003ee8:    f859cb04    Y...    LDR      r12,[r9],#4
        0x10003eec:    2100        .!      MOVS     r1,#0
        0x10003eee:    2a03        .*      CMP      r2,#3
        0x10003ef0:    d008        ..      BEQ      0x10003f04 ; _printf_core + 708
        0x10003ef2:    e009        ..      B        0x10003f08 ; _printf_core + 712
        0x10003ef4:    f1090107    ....    ADD      r1,r9,#7
        0x10003ef8:    f0210207    !...    BIC      r2,r1,#7
        0x10003efc:    e8f2c102    ....    LDRD     r12,r1,[r2],#8
        0x10003f00:    4691        .F      MOV      r9,r2
        0x10003f02:    e005        ..      B        0x10003f10 ; _printf_core + 720
        0x10003f04:    fa1ffc8c    ....    UXTH     r12,r12
        0x10003f08:    2a04        .*      CMP      r2,#4
        0x10003f0a:    d101        ..      BNE      0x10003f10 ; _printf_core + 720
        0x10003f0c:    f00c0cff    ....    AND      r12,r12,#0xff
        0x10003f10:    f04f0800    O...    MOV      r8,#0
        0x10003f14:    0722        ".      LSLS     r2,r4,#28
        0x10003f16:    d528        (.      BPL      0x10003f6a ; _printf_core + 810
        0x10003f18:    2870        p(      CMP      r0,#0x70
        0x10003f1a:    d006        ..      BEQ      0x10003f2a ; _printf_core + 746
        0x10003f1c:    9b00        ..      LDR      r3,[sp,#0]
        0x10003f1e:    f0830310    ....    EOR      r3,r3,#0x10
        0x10003f22:    ea53030a    S...    ORRS     r3,r3,r10
        0x10003f26:    d005        ..      BEQ      0x10003f34 ; _printf_core + 756
        0x10003f28:    e00e        ..      B        0x10003f48 ; _printf_core + 776
        0x10003f2a:    2240        @"      MOVS     r2,#0x40
        0x10003f2c:    f88d2004    ...     STRB     r2,[sp,#4]
        0x10003f30:    2201        ."      MOVS     r2,#1
        0x10003f32:    e008        ..      B        0x10003f46 ; _printf_core + 774
        0x10003f34:    ea5c0201    \...    ORRS     r2,r12,r1
        0x10003f38:    d006        ..      BEQ      0x10003f48 ; _printf_core + 776
        0x10003f3a:    2230        0"      MOVS     r2,#0x30
        0x10003f3c:    f88d2004    ...     STRB     r2,[sp,#4]
        0x10003f40:    f88d0005    ....    STRB     r0,[sp,#5]
        0x10003f44:    2202        ."      MOVS     r2,#2
        0x10003f46:    4690        .F      MOV      r8,r2
        0x10003f48:    9b00        ..      LDR      r3,[sp,#0]
        0x10003f4a:    f0830308    ....    EOR      r3,r3,#8
        0x10003f4e:    ea53030a    S...    ORRS     r3,r3,r10
        0x10003f52:    d10a        ..      BNE      0x10003f6a ; _printf_core + 810
        0x10003f54:    ea5c0201    \...    ORRS     r2,r12,r1
        0x10003f58:    d101        ..      BNE      0x10003f5e ; _printf_core + 798
        0x10003f5a:    0762        b.      LSLS     r2,r4,#29
        0x10003f5c:    d505        ..      BPL      0x10003f6a ; _printf_core + 810
        0x10003f5e:    2230        0"      MOVS     r2,#0x30
        0x10003f60:    f88d2004    ...     STRB     r2,[sp,#4]
        0x10003f64:    f04f0801    O...    MOV      r8,#1
        0x10003f68:    1e7f        ..      SUBS     r7,r7,#1
        0x10003f6a:    2858        X(      CMP      r0,#0x58
        0x10003f6c:    d004        ..      BEQ      0x10003f78 ; _printf_core + 824
        0x10003f6e:    a034        4.      ADR      r0,{pc}+0xd2 ; 0x10004040
        0x10003f70:    9003        ..      STR      r0,[sp,#0xc]
        0x10003f72:    a80e        ..      ADD      r0,sp,#0x38
        0x10003f74:    9002        ..      STR      r0,[sp,#8]
        0x10003f76:    e00d        ..      B        0x10003f94 ; _printf_core + 852
        0x10003f78:    a036        6.      ADR      r0,{pc}+0xdc ; 0x10004054
        0x10003f7a:    e7f9        ..      B        0x10003f70 ; _printf_core + 816
        0x10003f7c:    4653        SF      MOV      r3,r10
        0x10003f7e:    4660        `F      MOV      r0,r12
        0x10003f80:    9a00        ..      LDR      r2,[sp,#0]
        0x10003f82:    f7fef9de    ....    BL       __aeabi_uldivmod ; 0x10002342
        0x10003f86:    4684        .F      MOV      r12,r0
        0x10003f88:    9803        ..      LDR      r0,[sp,#0xc]
        0x10003f8a:    5c82        .\      LDRB     r2,[r0,r2]
        0x10003f8c:    9802        ..      LDR      r0,[sp,#8]
        0x10003f8e:    1e40        @.      SUBS     r0,r0,#1
        0x10003f90:    9002        ..      STR      r0,[sp,#8]
        0x10003f92:    7002        .p      STRB     r2,[r0,#0]
        0x10003f94:    ea5c0001    \...    ORRS     r0,r12,r1
        0x10003f98:    d1f0        ..      BNE      0x10003f7c ; _printf_core + 828
        0x10003f9a:    9802        ..      LDR      r0,[sp,#8]
        0x10003f9c:    a906        ..      ADD      r1,sp,#0x18
        0x10003f9e:    1a08        ..      SUBS     r0,r1,r0
        0x10003fa0:    f1000a20    .. .    ADD      r10,r0,#0x20
        0x10003fa4:    0760        `.      LSLS     r0,r4,#29
        0x10003fa6:    d502        ..      BPL      0x10003fae ; _printf_core + 878
        0x10003fa8:    f4243480    $..4    BIC      r4,r4,#0x10000
        0x10003fac:    e000        ..      B        0x10003fb0 ; _printf_core + 880
        0x10003fae:    2701        .'      MOVS     r7,#1
        0x10003fb0:    4557        WE      CMP      r7,r10
        0x10003fb2:    dd02        ..      BLE      0x10003fba ; _printf_core + 890
        0x10003fb4:    eba7000a    ....    SUB      r0,r7,r10
        0x10003fb8:    e000        ..      B        0x10003fbc ; _printf_core + 892
        0x10003fba:    2000        .       MOVS     r0,#0
        0x10003fbc:    eb00010a    ....    ADD      r1,r0,r10
        0x10003fc0:    9000        ..      STR      r0,[sp,#0]
        0x10003fc2:    9805        ..      LDR      r0,[sp,#0x14]
        0x10003fc4:    4441        AD      ADD      r1,r1,r8
        0x10003fc6:    1a40        @.      SUBS     r0,r0,r1
        0x10003fc8:    9005        ..      STR      r0,[sp,#0x14]
        0x10003fca:    03e0        ..      LSLS     r0,r4,#15
        0x10003fcc:    d406        ..      BMI      0x10003fdc ; _printf_core + 924
        0x10003fce:    465b        [F      MOV      r3,r11
        0x10003fd0:    4621        !F      MOV      r1,r4
        0x10003fd2:    9a17        ..      LDR      r2,[sp,#0x5c]
        0x10003fd4:    9805        ..      LDR      r0,[sp,#0x14]
        0x10003fd6:    f000f9b3    ....    BL       _printf_pre_padding ; 0x10004340
        0x10003fda:    4405        .D      ADD      r5,r5,r0
        0x10003fdc:    2700        .'      MOVS     r7,#0
        0x10003fde:    e006        ..      B        0x10003fee ; _printf_core + 942
        0x10003fe0:    a801        ..      ADD      r0,sp,#4
        0x10003fe2:    465a        ZF      MOV      r2,r11
        0x10003fe4:    5dc0        .]      LDRB     r0,[r0,r7]
        0x10003fe6:    9917        ..      LDR      r1,[sp,#0x5c]
        0x10003fe8:    4790        .G      BLX      r2
        0x10003fea:    1c6d        m.      ADDS     r5,r5,#1
        0x10003fec:    1c7f        ..      ADDS     r7,r7,#1
        0x10003fee:    4547        GE      CMP      r7,r8
        0x10003ff0:    dbf6        ..      BLT      0x10003fe0 ; _printf_core + 928
        0x10003ff2:    03e0        ..      LSLS     r0,r4,#15
        0x10003ff4:    d50c        ..      BPL      0x10004010 ; _printf_core + 976
        0x10003ff6:    465b        [F      MOV      r3,r11
        0x10003ff8:    4621        !F      MOV      r1,r4
        0x10003ffa:    9a17        ..      LDR      r2,[sp,#0x5c]
        0x10003ffc:    9805        ..      LDR      r0,[sp,#0x14]
        0x10003ffe:    f000f99f    ....    BL       _printf_pre_padding ; 0x10004340
        0x10004002:    4405        .D      ADD      r5,r5,r0
        0x10004004:    e004        ..      B        0x10004010 ; _printf_core + 976
        0x10004006:    2030        0       MOVS     r0,#0x30
        0x10004008:    465a        ZF      MOV      r2,r11
        0x1000400a:    9917        ..      LDR      r1,[sp,#0x5c]
        0x1000400c:    4790        .G      BLX      r2
        0x1000400e:    1c6d        m.      ADDS     r5,r5,#1
        0x10004010:    9900        ..      LDR      r1,[sp,#0]
        0x10004012:    1e48        H.      SUBS     r0,r1,#1
        0x10004014:    9000        ..      STR      r0,[sp,#0]
        0x10004016:    2900        .)      CMP      r1,#0
        0x10004018:    dcf5        ..      BGT      0x10004006 ; _printf_core + 966
        0x1000401a:    e008        ..      B        0x1000402e ; _printf_core + 1006
        0x1000401c:    9802        ..      LDR      r0,[sp,#8]
        0x1000401e:    9902        ..      LDR      r1,[sp,#8]
        0x10004020:    465a        ZF      MOV      r2,r11
        0x10004022:    7800        .x      LDRB     r0,[r0,#0]
        0x10004024:    1c49        I.      ADDS     r1,r1,#1
        0x10004026:    9102        ..      STR      r1,[sp,#8]
        0x10004028:    9917        ..      LDR      r1,[sp,#0x5c]
        0x1000402a:    4790        .G      BLX      r2
        0x1000402c:    1c6d        m.      ADDS     r5,r5,#1
        0x1000402e:    f1ba0100    ....    SUBS     r1,r10,#0
        0x10004032:    f1aa0a01    ....    SUB      r10,r10,#1
        0x10004036:    dcf1        ..      BGT      0x1000401c ; _printf_core + 988
        0x10004038:    e165        e.      B        0x10004306 ; _printf_core + 1734
    $d
        0x1000403a:    0000        ..      DCW    0
        0x1000403c:    00012809    .(..    DCD    75785
        0x10004040:    33323130    0123    DCD    858927408
        0x10004044:    37363534    4567    DCD    926299444
        0x10004048:    62613938    89ab    DCD    1650538808
        0x1000404c:    66656463    cdef    DCD    1717920867
        0x10004050:    00000000    ....    DCD    0
        0x10004054:    33323130    0123    DCD    858927408
        0x10004058:    37363534    4567    DCD    926299444
        0x1000405c:    42413938    89AB    DCD    1111570744
        0x10004060:    46454443    CDEF    DCD    1178944579
        0x10004064:    00000000    ....    DCD    0
    $t
        0x10004068:    f000f958    ..X.    BL       _printf_post_padding ; 0x1000431c
        0x1000406c:    4405        .D      ADD      r5,r5,r0
        0x1000406e:    1c76        v.      ADDS     r6,r6,#1
        0x10004070:    7830        0x      LDRB     r0,[r6,#0]
        0x10004072:    2800        .(      CMP      r0,#0
        0x10004074:    f47fadec    ....    BNE      0x10003c50 ; _printf_core + 16
        0x10004078:    b019        ..      ADD      sp,sp,#0x64
        0x1000407a:    4628        (F      MOV      r0,r5
        0x1000407c:    e8bd8ff0    ....    POP      {r4-r11,pc}
        0x10004080:    0762        b.      LSLS     r2,r4,#29
        0x10004082:    d400        ..      BMI      0x10004086 ; _printf_core + 1094
        0x10004084:    2706        .'      MOVS     r7,#6
        0x10004086:    f1090207    ....    ADD      r2,r9,#7
        0x1000408a:    f0220c07    "...    BIC      r12,r2,#7
        0x1000408e:    e8fc2302    ...#    LDRD     r2,r3,[r12],#8
        0x10004092:    46e1        .F      MOV      r9,r12
        0x10004094:    f0034800    ...H    AND      r8,r3,#0x80000000
        0x10004098:    ea5f0c08    _...    MOVS     r12,r8
        0x1000409c:    d002        ..      BEQ      0x100040a4 ; _printf_core + 1124
        0x1000409e:    f20f2c70    ..p,    ADR.W    r12,{pc}+0x272 ; 0x10004310
        0x100040a2:    e00d        ..      B        0x100040c0 ; _printf_core + 1152
        0x100040a4:    ea5f5c04    _..\    LSLS     r12,r4,#20
        0x100040a8:    d502        ..      BPL      0x100040b0 ; _printf_core + 1136
        0x100040aa:    f20f2c68    ..h,    ADR.W    r12,{pc}+0x26a ; 0x10004314
        0x100040ae:    e007        ..      B        0x100040c0 ; _printf_core + 1152
        0x100040b0:    ea5f7cc4    _..|    LSLS     r12,r4,#31
        0x100040b4:    d002        ..      BEQ      0x100040bc ; _printf_core + 1148
        0x100040b6:    f20f2c60    ..`,    ADR.W    r12,{pc}+0x262 ; 0x10004318
        0x100040ba:    e001        ..      B        0x100040c0 ; _printf_core + 1152
        0x100040bc:    f2af0c70    ..p.    ADR      r12,{pc}-0x6c ; 0x10004050
        0x100040c0:    f04f38ff    O..8    MOV      r8,#0xffffffff
        0x100040c4:    f0234300    #..C    BIC      r3,r3,#0x80000000
        0x100040c8:    f8cdc050    ..P.    STR      r12,[sp,#0x50]
        0x100040cc:    2865        e(      CMP      r0,#0x65
        0x100040ce:    d00c        ..      BEQ      0x100040ea ; _printf_core + 1194
        0x100040d0:    dc06        ..      BGT      0x100040e0 ; _printf_core + 1184
        0x100040d2:    2845        E(      CMP      r0,#0x45
        0x100040d4:    d009        ..      BEQ      0x100040ea ; _printf_core + 1194
        0x100040d6:    2846        F(      CMP      r0,#0x46
        0x100040d8:    d01d        ..      BEQ      0x10004116 ; _printf_core + 1238
        0x100040da:    2847        G(      CMP      r0,#0x47
        0x100040dc:    d13d        =.      BNE      0x1000415a ; _printf_core + 1306
        0x100040de:    e03d        =.      B        0x1000415c ; _printf_core + 1308
        0x100040e0:    2866        f(      CMP      r0,#0x66
        0x100040e2:    d018        ..      BEQ      0x10004116 ; _printf_core + 1238
        0x100040e4:    2867        g(      CMP      r0,#0x67
        0x100040e6:    d17e        ~.      BNE      0x100041e6 ; _printf_core + 1446
        0x100040e8:    e038        8.      B        0x1000415c ; _printf_core + 1308
        0x100040ea:    2100        .!      MOVS     r1,#0
        0x100040ec:    2f11        ./      CMP      r7,#0x11
        0x100040ee:    db01        ..      BLT      0x100040f4 ; _printf_core + 1204
        0x100040f0:    2011        .       MOVS     r0,#0x11
        0x100040f2:    e000        ..      B        0x100040f6 ; _printf_core + 1206
        0x100040f4:    1c78        x.      ADDS     r0,r7,#1
        0x100040f6:    e9cd0100    ....    STRD     r0,r1,[sp,#0]
        0x100040fa:    a906        ..      ADD      r1,sp,#0x18
        0x100040fc:    a80e        ..      ADD      r0,sp,#0x38
        0x100040fe:    f7fffcdd    ....    BL       _fp_digits ; 0x10003abc
        0x10004102:    e9dd010f    ....    LDRD     r0,r1,[sp,#0x3c]
        0x10004106:    9a0e        ..      LDR      r2,[sp,#0x38]
        0x10004108:    9103        ..      STR      r1,[sp,#0xc]
        0x1000410a:    2100        .!      MOVS     r1,#0
        0x1000410c:    9200        ..      STR      r2,[sp,#0]
        0x1000410e:    f1070a01    ....    ADD      r10,r7,#1
        0x10004112:    9104        ..      STR      r1,[sp,#0x10]
        0x10004114:    e04d        M.      B        0x100041b2 ; _printf_core + 1394
        0x10004116:    f04f4000    O..@    MOV      r0,#0x80000000
        0x1000411a:    9700        ..      STR      r7,[sp,#0]
        0x1000411c:    e9cd1001    ....    STRD     r1,r0,[sp,#4]
        0x10004120:    a906        ..      ADD      r1,sp,#0x18
        0x10004122:    a80e        ..      ADD      r0,sp,#0x38
        0x10004124:    f7fffcca    ....    BL       _fp_digits ; 0x10003abc
        0x10004128:    e9dd020f    ....    LDRD     r0,r2,[sp,#0x3c]
        0x1000412c:    9203        ..      STR      r2,[sp,#0xc]
        0x1000412e:    9b0e        ..      LDR      r3,[sp,#0x38]
        0x10004130:    9911        ..      LDR      r1,[sp,#0x44]
        0x10004132:    2200        ."      MOVS     r2,#0
        0x10004134:    f8dda00c    ....    LDR      r10,[sp,#0xc]
        0x10004138:    9300        ..      STR      r3,[sp,#0]
        0x1000413a:    9204        ..      STR      r2,[sp,#0x10]
        0x1000413c:    b911        ..      CBNZ     r1,0x10004144 ; _printf_core + 1284
        0x1000413e:    1c79        y.      ADDS     r1,r7,#1
        0x10004140:    eb000a01    ....    ADD      r10,r0,r1
        0x10004144:    ebb7000a    ....    SUBS     r0,r7,r10
        0x10004148:    d404        ..      BMI      0x10004154 ; _printf_core + 1300
        0x1000414a:    f1c030ff    ...0    RSB      r0,r0,#0xffffffff
        0x1000414e:    f1070a01    ....    ADD      r10,r7,#1
        0x10004152:    9004        ..      STR      r0,[sp,#0x10]
        0x10004154:    ebaa0007    ....    SUB      r0,r10,r7
        0x10004158:    9001        ..      STR      r0,[sp,#4]
        0x1000415a:    e044        D.      B        0x100041e6 ; _printf_core + 1446
        0x1000415c:    2f01        ./      CMP      r7,#1
        0x1000415e:    da00        ..      BGE      0x10004162 ; _printf_core + 1314
        0x10004160:    2701        .'      MOVS     r7,#1
        0x10004162:    2100        .!      MOVS     r1,#0
        0x10004164:    2f11        ./      CMP      r7,#0x11
        0x10004166:    dd01        ..      BLE      0x1000416c ; _printf_core + 1324
        0x10004168:    2011        .       MOVS     r0,#0x11
        0x1000416a:    e000        ..      B        0x1000416e ; _printf_core + 1326
        0x1000416c:    4638        8F      MOV      r0,r7
        0x1000416e:    e9cd0100    ....    STRD     r0,r1,[sp,#0]
        0x10004172:    a906        ..      ADD      r1,sp,#0x18
        0x10004174:    a80e        ..      ADD      r0,sp,#0x38
        0x10004176:    f7fffca1    ....    BL       _fp_digits ; 0x10003abc
        0x1000417a:    e9dd010f    ....    LDRD     r0,r1,[sp,#0x3c]
        0x1000417e:    9a0e        ..      LDR      r2,[sp,#0x38]
        0x10004180:    9103        ..      STR      r1,[sp,#0xc]
        0x10004182:    2100        .!      MOVS     r1,#0
        0x10004184:    9104        ..      STR      r1,[sp,#0x10]
        0x10004186:    9200        ..      STR      r2,[sp,#0]
        0x10004188:    46ba        .F      MOV      r10,r7
        0x1000418a:    0721        !.      LSLS     r1,r4,#28
        0x1000418c:    d40c        ..      BMI      0x100041a8 ; _printf_core + 1384
        0x1000418e:    9903        ..      LDR      r1,[sp,#0xc]
        0x10004190:    4551        QE      CMP      r1,r10
        0x10004192:    da00        ..      BGE      0x10004196 ; _printf_core + 1366
        0x10004194:    468a        .F      MOV      r10,r1
        0x10004196:    f1ba0f01    ....    CMP      r10,#1
        0x1000419a:    dd05        ..      BLE      0x100041a8 ; _printf_core + 1384
        0x1000419c:    9a00        ..      LDR      r2,[sp,#0]
        0x1000419e:    f1aa0101    ....    SUB      r1,r10,#1
        0x100041a2:    5c51        Q\      LDRB     r1,[r2,r1]
        0x100041a4:    2930        0)      CMP      r1,#0x30
        0x100041a6:    d008        ..      BEQ      0x100041ba ; _printf_core + 1402
        0x100041a8:    42b8        .B      CMP      r0,r7
        0x100041aa:    da02        ..      BGE      0x100041b2 ; _printf_core + 1394
        0x100041ac:    f1100f04    ....    CMN      r0,#4
        0x100041b0:    da06        ..      BGE      0x100041c0 ; _printf_core + 1408
        0x100041b2:    2101        .!      MOVS     r1,#1
        0x100041b4:    e9cd1001    ....    STRD     r1,r0,[sp,#4]
        0x100041b8:    e015        ..      B        0x100041e6 ; _printf_core + 1446
        0x100041ba:    f1aa0101    ....    SUB      r1,r10,#1
        0x100041be:    e7e9        ..      B        0x10004194 ; _printf_core + 1364
        0x100041c0:    2800        .(      CMP      r0,#0
        0x100041c2:    dc05        ..      BGT      0x100041d0 ; _printf_core + 1424
        0x100041c4:    9904        ..      LDR      r1,[sp,#0x10]
        0x100041c6:    4401        .D      ADD      r1,r1,r0
        0x100041c8:    9104        ..      STR      r1,[sp,#0x10]
        0x100041ca:    ebaa0100    ....    SUB      r1,r10,r0
        0x100041ce:    e002        ..      B        0x100041d6 ; _printf_core + 1430
        0x100041d0:    1c41        A.      ADDS     r1,r0,#1
        0x100041d2:    4551        QE      CMP      r1,r10
        0x100041d4:    dd00        ..      BLE      0x100041d8 ; _printf_core + 1432
        0x100041d6:    468a        .F      MOV      r10,r1
        0x100041d8:    9904        ..      LDR      r1,[sp,#0x10]
        0x100041da:    1a40        @.      SUBS     r0,r0,r1
        0x100041dc:    1c40        @.      ADDS     r0,r0,#1
        0x100041de:    9001        ..      STR      r0,[sp,#4]
        0x100041e0:    f04f4000    O..@    MOV      r0,#0x80000000
        0x100041e4:    9002        ..      STR      r0,[sp,#8]
        0x100041e6:    0720         .      LSLS     r0,r4,#28
        0x100041e8:    d404        ..      BMI      0x100041f4 ; _printf_core + 1460
        0x100041ea:    9801        ..      LDR      r0,[sp,#4]
        0x100041ec:    4550        PE      CMP      r0,r10
        0x100041ee:    db01        ..      BLT      0x100041f4 ; _printf_core + 1460
        0x100041f0:    f8cd8004    ....    STR      r8,[sp,#4]
        0x100041f4:    2000        .       MOVS     r0,#0
        0x100041f6:    f88d004f    ..O.    STRB     r0,[sp,#0x4f]
        0x100041fa:    9802        ..      LDR      r0,[sp,#8]
        0x100041fc:    f10d074f    ..O.    ADD      r7,sp,#0x4f
        0x10004200:    f1b04f00    ...O    CMP      r0,#0x80000000
        0x10004204:    d025        %.      BEQ      0x10004252 ; _printf_core + 1554
        0x10004206:    202b        +       MOVS     r0,#0x2b
        0x10004208:    900e        ..      STR      r0,[sp,#0x38]
        0x1000420a:    9802        ..      LDR      r0,[sp,#8]
        0x1000420c:    f04f0802    O...    MOV      r8,#2
        0x10004210:    2800        .(      CMP      r0,#0
        0x10004212:    da0c        ..      BGE      0x1000422e ; _printf_core + 1518
        0x10004214:    4240        @B      RSBS     r0,r0,#0
        0x10004216:    9002        ..      STR      r0,[sp,#8]
        0x10004218:    202d        -       MOVS     r0,#0x2d
        0x1000421a:    900e        ..      STR      r0,[sp,#0x38]
        0x1000421c:    e007        ..      B        0x1000422e ; _printf_core + 1518
        0x1000421e:    210a        .!      MOVS     r1,#0xa
        0x10004220:    9802        ..      LDR      r0,[sp,#8]
        0x10004222:    f7fef878    ..x.    BL       __aeabi_uidiv ; 0x10002316
        0x10004226:    3130        01      ADDS     r1,r1,#0x30
        0x10004228:    9002        ..      STR      r0,[sp,#8]
        0x1000422a:    f8071d01    ....    STRB     r1,[r7,#-1]!
        0x1000422e:    f1b80100    ....    SUBS     r1,r8,#0
        0x10004232:    f1a80801    ....    SUB      r8,r8,#1
        0x10004236:    dcf2        ..      BGT      0x1000421e ; _printf_core + 1502
        0x10004238:    9802        ..      LDR      r0,[sp,#8]
        0x1000423a:    2800        .(      CMP      r0,#0
        0x1000423c:    d1ef        ..      BNE      0x1000421e ; _printf_core + 1502
        0x1000423e:    1e79        y.      SUBS     r1,r7,#1
        0x10004240:    980e        ..      LDR      r0,[sp,#0x38]
        0x10004242:    7008        .p      STRB     r0,[r1,#0]
        0x10004244:    7830        0x      LDRB     r0,[r6,#0]
        0x10004246:    f0000020    .. .    AND      r0,r0,#0x20
        0x1000424a:    f0400045    @.E.    ORR      r0,r0,#0x45
        0x1000424e:    f8070d02    ....    STRB     r0,[r7,#-2]!
        0x10004252:    a812        ..      ADD      r0,sp,#0x48
        0x10004254:    1bc0        ..      SUBS     r0,r0,r7
        0x10004256:    f1000807    ....    ADD      r8,r0,#7
        0x1000425a:    9814        ..      LDR      r0,[sp,#0x50]
        0x1000425c:    7800        .x      LDRB     r0,[r0,#0]
        0x1000425e:    b100        ..      CBZ      r0,0x10004262 ; _printf_core + 1570
        0x10004260:    2001        .       MOVS     r0,#1
        0x10004262:    eb00010a    ....    ADD      r1,r0,r10
        0x10004266:    9801        ..      LDR      r0,[sp,#4]
        0x10004268:    eb0171e0    ...q    ADD      r1,r1,r0,ASR #31
        0x1000426c:    9805        ..      LDR      r0,[sp,#0x14]
        0x1000426e:    4441        AD      ADD      r1,r1,r8
        0x10004270:    1a40        @.      SUBS     r0,r0,r1
        0x10004272:    1e40        @.      SUBS     r0,r0,#1
        0x10004274:    9005        ..      STR      r0,[sp,#0x14]
        0x10004276:    03e0        ..      LSLS     r0,r4,#15
        0x10004278:    d406        ..      BMI      0x10004288 ; _printf_core + 1608
        0x1000427a:    465b        [F      MOV      r3,r11
        0x1000427c:    4621        !F      MOV      r1,r4
        0x1000427e:    9a17        ..      LDR      r2,[sp,#0x5c]
        0x10004280:    9805        ..      LDR      r0,[sp,#0x14]
        0x10004282:    f000f85d    ..].    BL       _printf_pre_padding ; 0x10004340
        0x10004286:    4405        .D      ADD      r5,r5,r0
        0x10004288:    9814        ..      LDR      r0,[sp,#0x50]
        0x1000428a:    7800        .x      LDRB     r0,[r0,#0]
        0x1000428c:    b118        ..      CBZ      r0,0x10004296 ; _printf_core + 1622
        0x1000428e:    465a        ZF      MOV      r2,r11
        0x10004290:    9917        ..      LDR      r1,[sp,#0x5c]
        0x10004292:    4790        .G      BLX      r2
        0x10004294:    1c6d        m.      ADDS     r5,r5,#1
        0x10004296:    03e0        ..      LSLS     r0,r4,#15
        0x10004298:    d524        $.      BPL      0x100042e4 ; _printf_core + 1700
        0x1000429a:    465b        [F      MOV      r3,r11
        0x1000429c:    4621        !F      MOV      r1,r4
        0x1000429e:    9a17        ..      LDR      r2,[sp,#0x5c]
        0x100042a0:    9805        ..      LDR      r0,[sp,#0x14]
        0x100042a2:    f000f84d    ..M.    BL       _printf_pre_padding ; 0x10004340
        0x100042a6:    4405        .D      ADD      r5,r5,r0
        0x100042a8:    e01c        ..      B        0x100042e4 ; _printf_core + 1700
        0x100042aa:    9804        ..      LDR      r0,[sp,#0x10]
        0x100042ac:    2800        .(      CMP      r0,#0
        0x100042ae:    db07        ..      BLT      0x100042c0 ; _printf_core + 1664
        0x100042b0:    e9dd0103    ....    LDRD     r0,r1,[sp,#0xc]
        0x100042b4:    4288        .B      CMP      r0,r1
        0x100042b6:    dd03        ..      BLE      0x100042c0 ; _printf_core + 1664
        0x100042b8:    9800        ..      LDR      r0,[sp,#0]
        0x100042ba:    5c40        @\      LDRB     r0,[r0,r1]
        0x100042bc:    9917        ..      LDR      r1,[sp,#0x5c]
        0x100042be:    e001        ..      B        0x100042c4 ; _printf_core + 1668
        0x100042c0:    9917        ..      LDR      r1,[sp,#0x5c]
        0x100042c2:    2030        0       MOVS     r0,#0x30
        0x100042c4:    465a        ZF      MOV      r2,r11
        0x100042c6:    4790        .G      BLX      r2
        0x100042c8:    9804        ..      LDR      r0,[sp,#0x10]
        0x100042ca:    f1050501    ....    ADD      r5,r5,#1
        0x100042ce:    1c40        @.      ADDS     r0,r0,#1
        0x100042d0:    9004        ..      STR      r0,[sp,#0x10]
        0x100042d2:    9801        ..      LDR      r0,[sp,#4]
        0x100042d4:    1e40        @.      SUBS     r0,r0,#1
        0x100042d6:    9001        ..      STR      r0,[sp,#4]
        0x100042d8:    d104        ..      BNE      0x100042e4 ; _printf_core + 1700
        0x100042da:    202e        .       MOVS     r0,#0x2e
        0x100042dc:    465a        ZF      MOV      r2,r11
        0x100042de:    9917        ..      LDR      r1,[sp,#0x5c]
        0x100042e0:    4790        .G      BLX      r2
        0x100042e2:    1c6d        m.      ADDS     r5,r5,#1
        0x100042e4:    f1ba0100    ....    SUBS     r1,r10,#0
        0x100042e8:    f1aa0a01    ....    SUB      r10,r10,#1
        0x100042ec:    dcdd        ..      BGT      0x100042aa ; _printf_core + 1642
        0x100042ee:    e005        ..      B        0x100042fc ; _printf_core + 1724
        0x100042f0:    f8170b01    ....    LDRB     r0,[r7],#1
        0x100042f4:    465a        ZF      MOV      r2,r11
        0x100042f6:    9917        ..      LDR      r1,[sp,#0x5c]
        0x100042f8:    4790        .G      BLX      r2
        0x100042fa:    1c6d        m.      ADDS     r5,r5,#1
        0x100042fc:    f1b80100    ....    SUBS     r1,r8,#0
        0x10004300:    f1a80801    ....    SUB      r8,r8,#1
        0x10004304:    dcf4        ..      BGT      0x100042f0 ; _printf_core + 1712
        0x10004306:    465b        [F      MOV      r3,r11
        0x10004308:    4621        !F      MOV      r1,r4
        0x1000430a:    9a17        ..      LDR      r2,[sp,#0x5c]
        0x1000430c:    9805        ..      LDR      r0,[sp,#0x14]
        0x1000430e:    e6ab        ..      B        0x10004068 ; _printf_core + 1064
    $d
        0x10004310:    0000002d    -...    DCD    45
        0x10004314:    0000002b    +...    DCD    43
        0x10004318:    00000020     ...    DCD    32
    $t
    i._printf_post_padding
    _printf_post_padding
        0x1000431c:    e92d41f0    -..A    PUSH     {r4-r8,lr}
        0x10004320:    4604        .F      MOV      r4,r0
        0x10004322:    2500        .%      MOVS     r5,#0
        0x10004324:    461e        .F      MOV      r6,r3
        0x10004326:    4617        .F      MOV      r7,r2
        0x10004328:    0488        ..      LSLS     r0,r1,#18
        0x1000432a:    d404        ..      BMI      0x10004336 ; _printf_post_padding + 26
        0x1000432c:    e005        ..      B        0x1000433a ; _printf_post_padding + 30
        0x1000432e:    4639        9F      MOV      r1,r7
        0x10004330:    2020                MOVS     r0,#0x20
        0x10004332:    47b0        .G      BLX      r6
        0x10004334:    1c6d        m.      ADDS     r5,r5,#1
        0x10004336:    1e64        d.      SUBS     r4,r4,#1
        0x10004338:    d5f9        ..      BPL      0x1000432e ; _printf_post_padding + 18
        0x1000433a:    4628        (F      MOV      r0,r5
        0x1000433c:    e8bd81f0    ....    POP      {r4-r8,pc}
    i._printf_pre_padding
    _printf_pre_padding
        0x10004340:    e92d41f0    -..A    PUSH     {r4-r8,lr}
        0x10004344:    4604        .F      MOV      r4,r0
        0x10004346:    2500        .%      MOVS     r5,#0
        0x10004348:    461e        .F      MOV      r6,r3
        0x1000434a:    4690        .F      MOV      r8,r2
        0x1000434c:    03c8        ..      LSLS     r0,r1,#15
        0x1000434e:    d501        ..      BPL      0x10004354 ; _printf_pre_padding + 20
        0x10004350:    2730        0'      MOVS     r7,#0x30
        0x10004352:    e000        ..      B        0x10004356 ; _printf_pre_padding + 22
        0x10004354:    2720         '      MOVS     r7,#0x20
        0x10004356:    0488        ..      LSLS     r0,r1,#18
        0x10004358:    d504        ..      BPL      0x10004364 ; _printf_pre_padding + 36
        0x1000435a:    e005        ..      B        0x10004368 ; _printf_pre_padding + 40
        0x1000435c:    4641        AF      MOV      r1,r8
        0x1000435e:    4638        8F      MOV      r0,r7
        0x10004360:    47b0        .G      BLX      r6
        0x10004362:    1c6d        m.      ADDS     r5,r5,#1
        0x10004364:    1e64        d.      SUBS     r4,r4,#1
        0x10004366:    d5f9        ..      BPL      0x1000435c ; _printf_pre_padding + 28
        0x10004368:    4628        (F      MOV      r0,r5
        0x1000436a:    e8bd81f0    ....    POP      {r4-r8,pc}
        0x1000436e:    0000        ..      MOVS     r0,r0
    i.puts
    puts
        0x10004370:    b510        ..      PUSH     {r4,lr}
        0x10004372:    4604        .F      MOV      r4,r0
        0x10004374:    e001        ..      B        0x1000437a ; puts + 10
        0x10004376:    f7fff92b    ..+.    BL       fputc ; 0x100035d0
        0x1000437a:    f8140b01    ....    LDRB     r0,[r4],#1
        0x1000437e:    4904        .I      LDR      r1,[pc,#16] ; [0x10004390] = 0x2000b000
        0x10004380:    2800        .(      CMP      r0,#0
        0x10004382:    d1f8        ..      BNE      0x10004376 ; puts + 6
        0x10004384:    e8bd4010    ...@    POP      {r4,lr}
        0x10004388:    200a        .       MOVS     r0,#0xa
        0x1000438a:    f7ffb921    ..!.    B        fputc ; 0x100035d0
    $d
        0x1000438e:    0000        ..      DCW    0
        0x10004390:    2000b000    ...     DCD    536915968
    $d.realdata
    .L.str.27
        0x10004394:    4552505b    [PRE    DCD    1163022427
        0x10004398:    45534943    CISE    DCD    1163086147
        0x1000439c:    205d5252    RR]     DCD    542986834
        0x100043a0:    61746164    data    DCD    1635017060
        0x100043a4:    73756220     bus    DCD    1937072672
        0x100043a8:    72726520     err    DCD    1920099616
        0x100043ac:    6820726f    or h    DCD    1746956911
        0x100043b0:    6f207361    as o    DCD    1864397665
        0x100043b4:    72756363    ccur    DCD    1920295779
        0x100043b8:    2c646572    red,    DCD    744777074
        0x100043bc:    20435020     PC     DCD    541282336
        0x100043c0:    7830203a    : 0x    DCD    2016419898
        0x100043c4:    78383025    %08x    DCD    2016948261
        0x100043c8:    0a0d        ..      DCW    2573
        0x100043ca:    00          .       DCB    0
    .L.str.20
        0x100043cb:    5b          [       DCB    91
        0x100043cc:    43434144    DACC    DCD    1128481092
        0x100043d0:    4c4f4956    VIOL    DCD    1280264534
        0x100043d4:    6854205d    ] Th    DCD    1750343773
        0x100043d8:    72702065    e pr    DCD    1919950949
        0x100043dc:    7365636f    oces    DCD    1936024431
        0x100043e0:    20726f73    sor     DCD    544370547
        0x100043e4:    65747461    atte    DCD    1702130785
        0x100043e8:    6574706d    mpte    DCD    1702129773
        0x100043ec:    20612064    d a     DCD    543236196
        0x100043f0:    64616f6c    load    DCD    1684107116
        0x100043f4:    20726f20     or     DCD    544370464
        0x100043f8:    726f7473    stor    DCD    1919906931
        0x100043fc:    74612065    e at    DCD    1952522341
        0x10004400:    6c206120     a l    DCD    1814061344
        0x10004404:    7461636f    ocat    DCD    1952539503
        0x10004408:    206e6f69    ion     DCD    544108393
        0x1000440c:    74616874    that    DCD    1952540788
        0x10004410:    656f6420     doe    DCD    1701798944
        0x10004414:    6f6e2073    s no    DCD    1869488243
        0x10004418:    65702074    t pe    DCD    1701847156
        0x1000441c:    74696d72    rmit    DCD    1953066354
        0x10004420:    65687420     the    DCD    1701344288
        0x10004424:    65706f20     ope    DCD    1701867296
        0x10004428:    69746172    rati    DCD    1769234802
        0x1000442c:    202c6e6f    on,     DCD    539782767
        0x10004430:    3a204350    PC :    DCD    975192912
        0x10004434:    25783020     0x%    DCD    628633632
        0x10004438:    0d783830    08x.    DCD    225982512
        0x1000443c:    000a        ..      DCW    10
    .L.str.19
        0x1000443e:    495b        [I      DCW    18779
        0x10004440:    56434341    ACCV    DCD    1447248705
        0x10004444:    5d4c4f49    IOL]    DCD    1565282121
        0x10004448:    20656854    The     DCD    543516756
        0x1000444c:    636f7270    proc    DCD    1668248176
        0x10004450:    6f737365    esso    DCD    1869837157
        0x10004454:    74612072    r at    DCD    1952522354
        0x10004458:    706d6574    temp    DCD    1886217588
        0x1000445c:    20646574    ted     DCD    543450484
        0x10004460:    69206e61    an i    DCD    1763733089
        0x10004464:    7274736e    nstr    DCD    1920234350
        0x10004468:    69746375    ucti    DCD    1769235317
        0x1000446c:    66206e6f    on f    DCD    1713401455
        0x10004470:    68637465    etch    DCD    1751348325
        0x10004474:    6f726620     fro    DCD    1869768224
        0x10004478:    2061206d    m a     DCD    543236205
        0x1000447c:    61636f6c    loca    DCD    1633906540
        0x10004480:    6e6f6974    tion    DCD    1852795252
        0x10004484:    61687420     tha    DCD    1634235424
        0x10004488:    6f642074    t do    DCD    1868832884
        0x1000448c:    6e207365    es n    DCD    1847620453
        0x10004490:    7020746f    ot p    DCD    1881175151
        0x10004494:    696d7265    ermi    DCD    1768780389
        0x10004498:    78652074    t ex    DCD    2019893364
        0x1000449c:    74756365    ecut    DCD    1953850213
        0x100044a0:    2c6e6f69    ion,    DCD    745434985
        0x100044a4:    20435020     PC     DCD    541282336
        0x100044a8:    7830203a    : 0x    DCD    2016419898
        0x100044ac:    78383025    %08x    DCD    2016948261
        0x100044b0:    0a0d        ..      DCW    2573
        0x100044b2:    00          .       DCB    0
    .L.str.21
        0x100044b3:    41          A       DCB    65
        0x100044b4:    303a2054    T :0    DCD    809115732
        0x100044b8:    38302578    x%08    DCD    942679416
        0x100044bc:    000a0d78    x...    DCD    658808
    .L.str.1
        0x100044c0:    7261485b    [Har    DCD    1918978139
        0x100044c4:    75614664    dFau    DCD    1969309284
        0x100044c8:    485f746c    lt_H    DCD    1214215276
        0x100044cc:    6c646e61    andl    DCD    1818521185
        0x100044d0:    435d7265    er]C    DCD    1130197605
        0x100044d4:    65727275    urre    DCD    1701999221
        0x100044d8:    6d20746e    nt m    DCD    1830843502
        0x100044dc:    203a7073    sp:     DCD    540700787
        0x100044e0:    30257830    0x%0    DCD    807761968
        0x100044e4:    000a5838    8X..    DCD    677944
    .Lstr.68
        0x100044e8:    564e495b    [INV    DCD    1447971163
        0x100044ec:    615d4350    PC]a    DCD    1633502032
        0x100044f0:    6e69206e    n in    DCD    1852383342
        0x100044f4:    72676574    tegr    DCD    1919378804
        0x100044f8:    20797469    ity     DCD    544830569
        0x100044fc:    63656863    chec    DCD    1667590243
        0x10004500:    7265206b    k er    DCD    1919230059
        0x10004504:    20726f72    ror     DCD    544370546
        0x10004508:    20736168    has     DCD    544432488
        0x1000450c:    7563636f    occu    DCD    1969447791
        0x10004510:    64657272    rred    DCD    1684370034
        0x10004514:    000d        ..      DCW    13
    .Lstr.66
        0x10004516:    555b        [U      DCW    21851
        0x10004518:    4645444e    NDEF    DCD    1178944590
        0x1000451c:    54534e49    INST    DCD    1414745673
        0x10004520:    6e615d52    R]an    DCD    1851874642
        0x10004524:    646e7520     und    DCD    1684960544
        0x10004528:    6e696665    efin    DCD    1852401253
        0x1000452c:    69206465    ed i    DCD    1763730533
        0x10004530:    7274736e    nstr    DCD    1920234350
        0x10004534:    69746375    ucti    DCD    1769235317
        0x10004538:    65206e6f    on e    DCD    1696624239
        0x1000453c:    726f7272    rror    DCD    1919906418
        0x10004540:    73616820     has    DCD    1935763488
        0x10004544:    63636f20     occ    DCD    1667460896
        0x10004548:    65727275    urre    DCD    1701999221
        0x1000454c:    0d64        d.      DCW    3428
        0x1000454e:    00          .       DCB    0
    .Lstr.72
        0x1000454f:    5b          [       DCB    91
        0x10004550:    42564944    DIVB    DCD    1112951108
        0x10004554:    52455a59    YZER    DCD    1380276825
        0x10004558:    6e615d4f    O]an    DCD    1851874639
        0x1000455c:    746e6920     int    DCD    1953392928
        0x10004560:    72656765    eger    DCD    1919248229
        0x10004564:    76696420     div    DCD    1986618400
        0x10004568:    6f697369    isio    DCD    1869181801
        0x1000456c:    7962206e    n by    DCD    2036473966
        0x10004570:    72657a20     zer    DCD    1919253024
        0x10004574:    7265206f    o er    DCD    1919230063
        0x10004578:    20726f72    ror     DCD    544370546
        0x1000457c:    20736168    has     DCD    544432488
        0x10004580:    7563636f    occu    DCD    1969447791
        0x10004584:    64657272    rred    DCD    1684370034
        0x10004588:    000d        ..      DCW    13
    .Lstr.61
        0x1000458a:    495b        [I      DCW    18779
        0x1000458c:    4552504d    MPRE    DCD    1163022413
        0x10004590:    45534943    CISE    DCD    1163086147
        0x10004594:    495d5252    RR]I    DCD    1230852690
        0x10004598:    6572706d    mpre    DCD    1701998701
        0x1000459c:    65736963    cise    DCD    1702062435
        0x100045a0:    74616420     dat    DCD    1952539680
        0x100045a4:    63612061    a ac    DCD    1667309665
        0x100045a8:    73736563    cess    DCD    1936942435
        0x100045ac:    72726520     err    DCD    1920099616
        0x100045b0:    6820726f    or h    DCD    1746956911
        0x100045b4:    6f207361    as o    DCD    1864397665
        0x100045b8:    72756363    ccur    DCD    1920295779
        0x100045bc:    0d646572    red.    DCD    224683378
        0x100045c0:    00          .       DCB    0
    .Lstr.71
        0x100045c1:    5b554e      [UN     DCB    91,85,78
        0x100045c4:    47494c41    ALIG    DCD    1195985985
        0x100045c8:    5d44454e    NED]    DCD    1564755278
        0x100045cc:    75206e61    an u    DCD    1965059681
        0x100045d0:    696c616e    nali    DCD    1768710510
        0x100045d4:    64656e67    gned    DCD    1684368999
        0x100045d8:    63636120     acc    DCD    1667457312
        0x100045dc:    20737365    ess     DCD    544437093
        0x100045e0:    6f727265    erro    DCD    1869771365
        0x100045e4:    61682072    r ha    DCD    1634214002
        0x100045e8:    636f2073    s oc    DCD    1668227187
        0x100045ec:    72727563    curr    DCD    1920103779
        0x100045f0:    000d6465    ed..    DCD    877669
    .Lstr.60
        0x100045f4:    5542495b    [IBU    DCD    1430407515
        0x100045f8:    52524553    SERR    DCD    1381123411
        0x100045fc:    736e695d    ]ins    DCD    1936615773
        0x10004600:    63757274    truc    DCD    1668641396
        0x10004604:    6e6f6974    tion    DCD    1852795252
        0x10004608:    73756220     bus    DCD    1937072672
        0x1000460c:    72726520     err    DCD    1920099616
        0x10004610:    6820726f    or h    DCD    1746956911
        0x10004614:    6f207361    as o    DCD    1864397665
        0x10004618:    72756363    ccur    DCD    1920295779
        0x1000461c:    0d646572    red.    DCD    224683378
        0x10004620:    00          .       DCB    0
    .Lstr.69
        0x10004621:    5b4e4f      [NO     DCB    91,78,79
        0x10004624:    615d5043    CP]a    DCD    1633505347
        0x10004628:    706f6320     cop    DCD    1886348064
        0x1000462c:    65636f72    roce    DCD    1701015410
        0x10004630:    726f7373    ssor    DCD    1919906675
        0x10004634:    73696420     dis    DCD    1936286752
        0x10004638:    656c6261    able    DCD    1701601889
        0x1000463c:    726f2064    d or    DCD    1919885412
        0x10004640:    746f6e20     not    DCD    1953459744
        0x10004644:    65727020     pre    DCD    1701998624
        0x10004648:    746e6573    sent    DCD    1953391987
        0x1000464c:    72726520     err    DCD    1920099616
        0x10004650:    6820726f    or h    DCD    1746956911
        0x10004654:    6f207361    as o    DCD    1864397665
        0x10004658:    72756363    ccur    DCD    1920295779
        0x1000465c:    0d646572    red.    DCD    224683378
        0x10004660:    00          .       DCB    0
    .Lstr.70
        0x10004661:    5b5354      [ST     DCB    91,83,84
        0x10004664:    5d464f4b    KOF]    DCD    1564888907
        0x10004668:    74732061    a st    DCD    1953701985
        0x1000466c:    206b6361    ack     DCD    543908705
        0x10004670:    7265766f    over    DCD    1919252079
        0x10004674:    776f6c66    flow    DCD    2003790950
        0x10004678:    72726520     err    DCD    1920099616
        0x1000467c:    6820726f    or h    DCD    1746956911
        0x10004680:    6f207361    as o    DCD    1864397665
        0x10004684:    72756363    ccur    DCD    1920295779
        0x10004688:    0d646572    red.    DCD    224683378
        0x1000468c:    00          .       DCB    0
    .Lstr.67
        0x1000468d:    5b494e      [IN     DCB    91,73,78
        0x10004690:    41545356    VSTA    DCD    1096045398
        0x10004694:    205d4554    TE]     DCD    542983508
        0x10004698:    45206e61    an E    DCD    1159753313
        0x1000469c:    2e525350    PSR.    DCD    777147216
        0x100046a0:    726f2054    T or    DCD    1919885396
        0x100046a4:    53504520     EPS    DCD    1397769504
        0x100046a8:    54492e52    R.IT    DCD    1414082130
        0x100046ac:    6c617620     val    DCD    1818326560
        0x100046b0:    74696469    idit    DCD    1953064041
        0x100046b4:    72652079    y er    DCD    1919230073
        0x100046b8:    20726f72    ror     DCD    544370546
        0x100046bc:    20736168    has     DCD    544432488
        0x100046c0:    7563636f    occu    DCD    1969447791
        0x100046c4:    64657272    rred    DCD    1684370034
        0x100046c8:    000d        ..      DCW    13
    .Lstr.58
        0x100046ca:    4d5b        [M      DCW    19803
        0x100046cc:    4550534c    LSPE    DCD    1162892108
        0x100046d0:    415d5252    RR]A    DCD    1096634962
        0x100046d4:    6d654d20     Mem    DCD    1835355424
        0x100046d8:    616e614d    Mana    DCD    1634623821
        0x100046dc:    66206567    ge f    DCD    1713399143
        0x100046e0:    746c7561    ault    DCD    1953264993
        0x100046e4:    63636f20     occ    DCD    1667460896
        0x100046e8:    65727275    urre    DCD    1701999221
        0x100046ec:    75642064    d du    DCD    1969496164
        0x100046f0:    676e6972    ring    DCD    1735289202
        0x100046f4:    6f6c6620     flo    DCD    1869375008
        0x100046f8:    6e697461    atin    DCD    1852404833
        0x100046fc:    6f702d67    g-po    DCD    1869622631
        0x10004700:    20746e69    int     DCD    544501353
        0x10004704:    797a616c    lazy    DCD    2038063468
        0x10004708:    61747320     sta    DCD    1635021600
        0x1000470c:    70206574    te p    DCD    1881171316
        0x10004710:    65736572    rese    DCD    1702061426
        0x10004714:    74617672    rvat    DCD    1952544370
        0x10004718:    0d6e6f69    ion.    DCD    225341289
        0x1000471c:    00          .       DCB    0
    .Lstr.64
        0x1000471d:    5b4c53      [LS     DCB    91,76,83
        0x10004720:    52524550    PERR    DCD    1381123408
        0x10004724:    6220415d    ]A b    DCD    1646281053
        0x10004728:    66207375    us f    DCD    1713402741
        0x1000472c:    746c7561    ault    DCD    1953264993
        0x10004730:    63636f20     occ    DCD    1667460896
        0x10004734:    65727275    urre    DCD    1701999221
        0x10004738:    75642064    d du    DCD    1969496164
        0x1000473c:    676e6972    ring    DCD    1735289202
        0x10004740:    6f6c6620     flo    DCD    1869375008
        0x10004744:    6e697461    atin    DCD    1852404833
        0x10004748:    6f702d67    g-po    DCD    1869622631
        0x1000474c:    20746e69    int     DCD    544501353
        0x10004750:    797a616c    lazy    DCD    2038063468
        0x10004754:    61747320     sta    DCD    1635021600
        0x10004758:    70206574    te p    DCD    1881171316
        0x1000475c:    65736572    rese    DCD    1702061426
        0x10004760:    74617672    rvat    DCD    1952544370
        0x10004764:    0d6e6f69    ion.    DCD    225341289
        0x10004768:    00          .       DCB    0
    .Lstr.56
        0x10004769:    5b4d55      [MU     DCB    91,77,85
        0x1000476c:    4b54534e    NSTK    DCD    1263817550
        0x10004770:    5d525245    ERR]    DCD    1565676101
        0x10004774:    74736e55    Unst    DCD    1953721941
        0x10004778:    206b6361    ack     DCD    543908705
        0x1000477c:    20726f66    for     DCD    544370534
        0x10004780:    65206e61    an e    DCD    1696624225
        0x10004784:    70656378    xcep    DCD    1885692792
        0x10004788:    6e6f6974    tion    DCD    1852795252
        0x1000478c:    74657220     ret    DCD    1952805408
        0x10004790:    206e7275    urn     DCD    544109173
        0x10004794:    20736168    has     DCD    544432488
        0x10004798:    73756163    caus    DCD    1937072483
        0x1000479c:    6f206465    ed o    DCD    1864393829
        0x100047a0:    6f20656e    ne o    DCD    1864394094
        0x100047a4:    6f6d2072    r mo    DCD    1869422706
        0x100047a8:    61206572    re a    DCD    1629513074
        0x100047ac:    73656363    cces    DCD    1936024419
        0x100047b0:    69762073    s vi    DCD    1769349235
        0x100047b4:    74616c6f    olat    DCD    1952541807
        0x100047b8:    736e6f69    ions    DCD    1936617321
        0x100047bc:    000d        ..      DCW    13
    .Lstr.57
        0x100047be:    4d5b        [M      DCW    19803
        0x100047c0:    454b5453    STKE    DCD    1162564691
        0x100047c4:    535d5252    RR]S    DCD    1398624850
        0x100047c8:    6b636174    tack    DCD    1801675124
        0x100047cc:    20676e69    ing     DCD    543649385
        0x100047d0:    20726f66    for     DCD    544370534
        0x100047d4:    65206e61    an e    DCD    1696624225
        0x100047d8:    70656378    xcep    DCD    1885692792
        0x100047dc:    6e6f6974    tion    DCD    1852795252
        0x100047e0:    746e6520     ent    DCD    1953391904
        0x100047e4:    68207972    ry h    DCD    1746958706
        0x100047e8:    63207361    as c    DCD    1663071073
        0x100047ec:    65737561    ause    DCD    1702065505
        0x100047f0:    6e6f2064    d on    DCD    1852776548
        0x100047f4:    726f2065    e or    DCD    1919885413
        0x100047f8:    726f6d20     mor    DCD    1919905056
        0x100047fc:    63612065    e ac    DCD    1667309669
        0x10004800:    73736563    cess    DCD    1936942435
        0x10004804:    6f697620     vio    DCD    1869182496
        0x10004808:    6974616c    lati    DCD    1769234796
        0x1000480c:    0d736e6f    ons.    DCD    225668719
        0x10004810:    00          .       DCB    0
    .Lstr.62
        0x10004811:    5b554e      [UN     DCB    91,85,78
        0x10004814:    454b5453    STKE    DCD    1162564691
        0x10004818:    555d5252    RR]U    DCD    1432179282
        0x1000481c:    6174736e    nsta    DCD    1635021678
        0x10004820:    66206b63    ck f    DCD    1713400675
        0x10004824:    6120726f    or a    DCD    1629516399
        0x10004828:    7865206e    n ex    DCD    2019893358
        0x1000482c:    74706563    cept    DCD    1953523043
        0x10004830:    206e6f69    ion     DCD    544108393
        0x10004834:    75746572    retu    DCD    1970562418
        0x10004838:    68206e72    rn h    DCD    1746955890
        0x1000483c:    63207361    as c    DCD    1663071073
        0x10004840:    65737561    ause    DCD    1702065505
        0x10004844:    6e6f2064    d on    DCD    1852776548
        0x10004848:    726f2065    e or    DCD    1919885413
        0x1000484c:    726f6d20     mor    DCD    1919905056
        0x10004850:    75422065    e Bu    DCD    1967267941
        0x10004854:    75614673    sFau    DCD    1969309299
        0x10004858:    0d73746c    lts.    DCD    225670252
        0x1000485c:    00          .       DCB    0
    .Lstr.63
        0x1000485d:    5b5354      [ST     DCB    91,83,84
        0x10004860:    5252454b    KERR    DCD    1381123403
        0x10004864:    6174535d    ]Sta    DCD    1635013469
        0x10004868:    6e696b63    ckin    DCD    1852402531
        0x1000486c:    6f662067    g fo    DCD    1868963943
        0x10004870:    6e612072    r an    DCD    1851859058
        0x10004874:    63786520     exc    DCD    1668834592
        0x10004878:    69747065    epti    DCD    1769238629
        0x1000487c:    65206e6f    on e    DCD    1696624239
        0x10004880:    7972746e    ntry    DCD    2037544046
        0x10004884:    73616820     has    DCD    1935763488
        0x10004888:    75616320     cau    DCD    1969316640
        0x1000488c:    20646573    sed     DCD    543450483
        0x10004890:    20656e6f    one     DCD    543518319
        0x10004894:    6d20726f    or m    DCD    1830842991
        0x10004898:    2065726f    ore     DCD    543519343
        0x1000489c:    46737542    BusF    DCD    1181971778
        0x100048a0:    746c7561    ault    DCD    1953264993
        0x100048a4:    0d73        s.      DCW    3443
        0x100048a6:    00          .       DCB    0
    .Lstr.55
        0x100048a7:    4d          M       DCB    77
        0x100048a8:    614d6d65    emMa    DCD    1632464229
        0x100048ac:    6567616e    nage    DCD    1701273966
        0x100048b0:    75614620     Fau    DCD    1969309216
        0x100048b4:    000d746c    lt..    DCD    881772
    .Lstr.65
        0x100048b8:    67617355    Usag    DCD    1734439765
        0x100048bc:    61462065    e Fa    DCD    1631985765
        0x100048c0:    0d746c75    ult.    DCD    225733749
        0x100048c4:    00          .       DCB    0
    .Lstr.54
        0x100048c5:    436f6e      Con     DCB    67,111,110
        0x100048c8:    75676966    figu    DCD    1969711462
        0x100048cc:    6c626172    rabl    DCD    1818386802
        0x100048d0:    61462065    e Fa    DCD    1631985765
        0x100048d4:    0d746c75    ult.    DCD    225733749
        0x100048d8:    00          .       DCB    0
    .Lstr.52
        0x100048d9:    566563      Vec     DCB    86,101,99
        0x100048dc:    20726f74    tor     DCD    544370548
        0x100048e0:    6c756146    Faul    DCD    1819631942
        0x100048e4:    0d74        t.      DCW    3444
        0x100048e6:    00          .       DCB    0
    .Lstr.59
        0x100048e7:    42          B       DCB    66
        0x100048e8:    46207375    us F    DCD    1176531829
        0x100048ec:    746c7561    ault    DCD    1953264993
        0x100048f0:    000d        ..      DCW    13
    .Lstr.53
        0x100048f2:    6544        De      DCW    25924
        0x100048f4:    20677562    bug     DCD    543651170
        0x100048f8:    6e657645    Even    DCD    1852143173
        0x100048fc:    61462074    t Fa    DCD    1631985780
        0x10004900:    0d746c75    ult.    DCD    225733749
        0x10004904:    00          .       DCB    0
    .Lstr.48
        0x10004905:    4f6363      Occ     DCB    79,99,99
        0x10004908:    64657275    ured    DCD    1684370037
        0x1000490c:    206e6920     in     DCD    544106784
        0x10004910:    6b736174    task    DCD    1802723700
        0x10004914:    002e        ..      DCW    46
    .Lstr.49
        0x10004916:    7355        Us      DCW    29525
        0x10004918:    20676e69    ing     DCD    543649385
        0x1000491c:    4d323375    u32M    DCD    1295135605
        0x10004920:    002e7073    sp..    DCD    3043443
    .Lstr
        0x10004924:    7563634f    Occu    DCD    1969447759
        0x10004928:    20646572    red     DCD    543450482
        0x1000492c:    69206e69    in i    DCD    1763733097
        0x10004930:    7265746e    nter    DCD    1919251566
        0x10004934:    74707572    rupt    DCD    1953527154
        0x10004938:    0000002e    ....    DCD    46

** Section #4 'RAM_VECTOR' (SHT_NOBITS) [SHF_ALLOC + SHF_WRITE]
    Size   : 300 bytes (alignment 512)
    Address: 0x20003000


** Section #5 'RAM_CODE' (SHT_PROGBITS) [SHF_ALLOC + SHF_EXECINSTR]
    Size   : 304 bytes (alignment 4)
    Address: 0x20003200

    $t
    STIM0_IRQ0_Handler
        0x20003200:    b510        ..      PUSH     {r4,lr}
        0x20003202:    b082        ..      SUB      sp,sp,#8
        0x20003204:    f2420400    B...    MOVW     r4,#0x2000
        0x20003208:    2000        .       MOVS     r0,#0
        0x2000320a:    f2c60405    ....    MOVT     r4,#0x6005
        0x2000320e:    f8ad0006    ....    STRH     r0,[sp,#6]
        0x20003212:    9000        ..      STR      r0,[sp,#0]
        0x20003214:    f10d0106    ....    ADD      r1,sp,#6
        0x20003218:    4620         F      MOV      r0,r4
        0x2000321a:    f000f865    ..e.    BL       $Ven$TT$L$$rom_hw_stim_get_interrupt_flag ; 0x200032e8
        0x2000321e:    f8bd0006    ....    LDRH     r0,[sp,#6]
        0x20003222:    07c0        ..      LSLS     r0,r0,#31
        0x20003224:    d015        ..      BEQ      0x20003252 ; STIM0_IRQ0_Handler + 82
        0x20003226:    4620         F      MOV      r0,r4
        0x20003228:    2101        .!      MOVS     r1,#1
        0x2000322a:    f000f862    ..b.    BL       $Ven$TT$L$$rom_hw_stim_clear_interrupt_flag ; 0x200032f2
        0x2000322e:    f24b0064    K.d.    MOV      r0,#0xb064
        0x20003232:    f2c20000    ....    MOVT     r0,#0x2000
        0x20003236:    6801        .h      LDR      r1,[r0,#0]
        0x20003238:    3101        .1      ADDS     r1,#1
        0x2000323a:    6001        .`      STR      r1,[r0,#0]
        0x2000323c:    4669        iF      MOV      r1,sp
        0x2000323e:    4620         F      MOV      r0,r4
        0x20003240:    f000f85c    ..\.    BL       $Ven$TT$L$$rom_hw_stim_get_count ; 0x200032fc
        0x20003244:    9800        ..      LDR      r0,[sp,#0]
        0x20003246:    2100        .!      MOVS     r1,#0
        0x20003248:    f1000221    ..!.    ADD      r2,r0,#0x21
        0x2000324c:    4620         F      MOV      r0,r4
        0x2000324e:    f000f85a    ..Z.    BL       $Ven$TT$L$$rom_hw_stim_set_compare ; 0x20003306
        0x20003252:    f8bd0006    ....    LDRH     r0,[sp,#6]
        0x20003256:    f0100130    ..0.    ANDS     r1,r0,#0x30
        0x2000325a:    f8ad1006    ....    STRH     r1,[sp,#6]
        0x2000325e:    bf1c        ..      ITT      NE
        0x20003260:    4620         F      MOVNE    r0,r4
        0x20003262:    f000f846    ..F.    BLNE     $Ven$TT$L$$rom_hw_stim_clear_interrupt_flag ; 0x200032f2
        0x20003266:    b002        ..      ADD      sp,sp,#8
        0x20003268:    bd10        ..      POP      {r4,pc}
        0x2000326a:    bf00        ..      NOP      
    DMA_IRQ6_Handler
        0x2000326c:    b5b0        ..      PUSH     {r4,r5,r7,lr}
        0x2000326e:    b082        ..      SUB      sp,sp,#8
        0x20003270:    f2481480    H...    MOV      r4,#0x8180
        0x20003274:    f2c50400    ....    MOVT     r4,#0x5000
        0x20003278:    2500        .%      MOVS     r5,#0
        0x2000327a:    f10d0107    ....    ADD      r1,sp,#7
        0x2000327e:    4620         F      MOV      r0,r4
        0x20003280:    f88d5007    ...P    STRB     r5,[sp,#7]
        0x20003284:    f000f844    ..D.    BL       $Ven$TT$L$$rom_hw_dma_get_interrupt_flag ; 0x20003310
        0x20003288:    f89d1007    ....    LDRB     r1,[sp,#7]
        0x2000328c:    b179        y.      CBZ      r1,0x200032ae ; DMA_IRQ6_Handler + 66
        0x2000328e:    4620         F      MOV      r0,r4
        0x20003290:    f000f843    ..C.    BL       $Ven$TT$L$$rom_hw_dma_clear_interrupt_flag ; 0x2000331a
        0x20003294:    f89d0007    ....    LDRB     r0,[sp,#7]
        0x20003298:    0780        ..      LSLS     r0,r0,#30
        0x2000329a:    d508        ..      BPL      0x200032ae ; DMA_IRQ6_Handler + 66
        0x2000329c:    4620         F      MOV      r0,r4
        0x2000329e:    f000f841    ..A.    BL       $Ven$TT$L$$rom_hw_dma_disable ; 0x20003324
        0x200032a2:    f24b0044    K.D.    MOV      r0,#0xb044
        0x200032a6:    f2c20000    ....    MOVT     r0,#0x2000
        0x200032aa:    2101        .!      MOVS     r1,#1
        0x200032ac:    7001        .p      STRB     r1,[r0,#0]
        0x200032ae:    3440        @4      ADDS     r4,r4,#0x40
        0x200032b0:    f10d0107    ....    ADD      r1,sp,#7
        0x200032b4:    4620         F      MOV      r0,r4
        0x200032b6:    f88d5007    ...P    STRB     r5,[sp,#7]
        0x200032ba:    f000f829    ..).    BL       $Ven$TT$L$$rom_hw_dma_get_interrupt_flag ; 0x20003310
        0x200032be:    f89d1007    ....    LDRB     r1,[sp,#7]
        0x200032c2:    b179        y.      CBZ      r1,0x200032e4 ; DMA_IRQ6_Handler + 120
        0x200032c4:    4620         F      MOV      r0,r4
        0x200032c6:    f000f828    ..(.    BL       $Ven$TT$L$$rom_hw_dma_clear_interrupt_flag ; 0x2000331a
        0x200032ca:    f89d0007    ....    LDRB     r0,[sp,#7]
        0x200032ce:    0780        ..      LSLS     r0,r0,#30
        0x200032d0:    d508        ..      BPL      0x200032e4 ; DMA_IRQ6_Handler + 120
        0x200032d2:    4620         F      MOV      r0,r4
        0x200032d4:    f000f826    ..&.    BL       $Ven$TT$L$$rom_hw_dma_disable ; 0x20003324
        0x200032d8:    f24b0068    K.h.    MOV      r0,#0xb068
        0x200032dc:    f2c20000    ....    MOVT     r0,#0x2000
        0x200032e0:    2101        .!      MOVS     r1,#1
        0x200032e2:    7001        .p      STRB     r1,[r0,#0]
        0x200032e4:    b002        ..      ADD      sp,sp,#8
        0x200032e6:    bdb0        ..      POP      {r4,r5,r7,pc}
    $Ven$TT$L$$rom_hw_stim_get_interrupt_flag
        0x200032e8:    f64b5cd5    K..\    MOV      r12,#0xbdd5
        0x200032ec:    f2c00c00    ....    MOVT     r12,#0
        0x200032f0:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_stim_clear_interrupt_flag
        0x200032f2:    f64b3cd1    K..<    MOV      r12,#0xbbd1
        0x200032f6:    f2c00c00    ....    MOVT     r12,#0
        0x200032fa:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_stim_get_count
        0x200032fc:    f64b5ca5    K..\    MOV      r12,#0xbda5
        0x20003300:    f2c00c00    ....    MOVT     r12,#0
        0x20003304:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_stim_set_compare
        0x20003306:    f64b6c65    K.el    MOV      r12,#0xbe65
        0x2000330a:    f2c00c00    ....    MOVT     r12,#0
        0x2000330e:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_dma_get_interrupt_flag
        0x20003310:    f2482c1d    H..,    MOV      r12,#0x821d
        0x20003314:    f2c00c00    ....    MOVT     r12,#0
        0x20003318:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_dma_clear_interrupt_flag
        0x2000331a:    f2480c59    H.Y.    MOV      r12,#0x8059
        0x2000331e:    f2c00c00    ....    MOVT     r12,#0
        0x20003322:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_dma_disable
        0x20003324:    f2480cad    H...    MOV      r12,#0x80ad
        0x20003328:    f2c00c00    ....    MOVT     r12,#0
        0x2000332c:    4760        `G      BX       r12
        0x2000332e:    0000        ..      MOVS     r0,r0

** Section #6 'RAM_DATA' (SHT_PROGBITS) [SHF_ALLOC + SHF_WRITE]
    Size   : 8 bytes (alignment 4)
    Address: 0x2000b000


** Section #7 'RAM_DATA' (SHT_NOBITS) [SHF_ALLOC + SHF_WRITE]
    Size   : 120 bytes (alignment 4)
    Address: 0x2000b008


** Section #8 'RAM_STACK_HEAP' (SHT_NOBITS) [SHF_ALLOC + SHF_WRITE]
    Size   : 4096 bytes (alignment 8)
    Address: 0x2000f000


** Section #9 '.debug_abbrev' (SHT_PROGBITS)
    Size   : 2556 bytes


** Section #10 '.debug_frame' (SHT_PROGBITS)
    Size   : 3212 bytes


** Section #11 '.debug_info' (SHT_PROGBITS)
    Size   : 17192 bytes


** Section #12 '.debug_line' (SHT_PROGBITS)
    Size   : 6108 bytes


** Section #13 '.debug_loc' (SHT_PROGBITS)
    Size   : 2940 bytes


** Section #14 '.debug_ranges' (SHT_PROGBITS)
    Size   : 472 bytes


** Section #15 '.debug_str' (SHT_PROGBITS)
    Size   : 18599 bytes


** Section #16 '.symtab' (SHT_SYMTAB)
    Size   : 20032 bytes (alignment 4)
    String table #17 '.strtab'
    Last local symbol no. 188


** Section #17 '.strtab' (SHT_STRTAB)
    Size   : 28172 bytes


** Section #18 '.note' (SHT_NOTE)
    Size   : 48 bytes (alignment 4)


** Section #19 '.comment' (SHT_PROGBITS)
    Size   : 1500 bytes


** Section #20 '.shstrtab' (SHT_STRTAB)
    Size   : 208 bytes


