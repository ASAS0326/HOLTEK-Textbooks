
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

    Program header offset: 110380 (0x0001af2c)
    Section header offset: 110444 (0x0001af6c)

    Section header string table index: 20

========================================================================

** Program header #0 (PT_LOAD) [PF_R]
    Size : 4096 bytes
    Virtual address: 0x10000000 (Alignment 4)


====================================

** Program header #1 (PT_LOAD) [PF_X + PF_W + PF_R + PF_ARM_ENTRY]
    Size : 19596 bytes (6716 bytes in file)
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
        0x10002084:    20003201    .2.     DCD    536883713
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
        0x100020d0:    100021e3    .!..    DCD    268444131
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
        0x10002104:    100021fd    .!..    DCD    268444157
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
        0x10002148:    4800        .H      LDR      r0,[pc,#0] ; [0x1000214c] = 0x10002c61
        0x1000214a:    4700        .G      BX       r0
    $d
        0x1000214c:    10002c61    a,..    DCD    268446817
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
        0x10002174:    4b2a        *K      LDR      r3,[pc,#168] ; [0x10002220] = 0x1000289d
        0x10002176:    4798        .G      BLX      r3
        0x10002178:    e7fe        ..      B        0x10002178 ; NMI_Handler + 16
    HardFault_Handler
        0x1000217a:    ea5f000e    _...    MOVS     r0,lr
        0x1000217e:    f3ef8108    ....    MRS      r1,MSP
        0x10002182:    f3ef8209    ....    MRS      r2,PSP
        0x10002186:    4b27        'K      LDR      r3,[pc,#156] ; [0x10002224] = 0x100023b5
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
        0x100021bc:    e7fe        ..      B        0x100021bc ; I2C2_IRQ_Handler + 2
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
    DMA_IRQ6_Handler
        0x100021e2:    e7fe        ..      B        DMA_IRQ6_Handler ; 0x100021e2
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
    STIM0_IRQ0_Handler
        0x100021fc:    e7fe        ..      B        STIM0_IRQ0_Handler ; 0x100021fc
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
        0x10002220:    1000289d    .(..    DCD    268445853
        0x10002224:    100023b5    .#..    DCD    268444597
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
        0x100022c0:    1000392c    ,9..    DCD    268450092
        0x100022c4:    20003200    .2.     DCD    536883712
        0x100022c8:    0000010c    ....    DCD    268
        0x100022cc:    100022a0    ."..    DCD    268444320
        0x100022d0:    10003a38    8:..    DCD    268450360
        0x100022d4:    2000b000    ...     DCD    536915968
        0x100022d8:    00000004    ....    DCD    4
        0x100022dc:    100022a0    ."..    DCD    268444320
        0x100022e0:    10003a3c    <:..    DCD    268450364
        0x100022e4:    2000b004    ...     DCD    536915972
        0x100022e8:    0000204c    L ..    DCD    8268
        0x100022ec:    100022b0    ."..    DCD    268444336
    Region$$Table$$Limit

** Section #3 'FLASH_CACHE_CODE' (SHT_PROGBITS) [SHF_ALLOC + SHF_EXECINSTR]
    Size   : 5692 bytes (alignment 4)
    Address: 0x100022f0

    $t
    .text
    __aeabi_memset
    __aeabi_memset4
    __aeabi_memset8
        0x100022f0:    b2d2        ..      UXTB     r2,r2
        0x100022f2:    e001        ..      B        0x100022f8 ; __aeabi_memset + 8
        0x100022f4:    f8002b01    ...+    STRB     r2,[r0],#1
        0x100022f8:    1e49        I.      SUBS     r1,r1,#1
        0x100022fa:    d2fb        ..      BCS      0x100022f4 ; __aeabi_memset + 4
        0x100022fc:    4770        pG      BX       lr
    __aeabi_memclr
    __aeabi_memclr4
    __aeabi_memclr8
        0x100022fe:    2200        ."      MOVS     r2,#0
        0x10002300:    e7f6        ..      B        __aeabi_memset ; 0x100022f0
    _memset$wrapper
        0x10002302:    b510        ..      PUSH     {r4,lr}
        0x10002304:    4613        .F      MOV      r3,r2
        0x10002306:    460a        .F      MOV      r2,r1
        0x10002308:    4604        .F      MOV      r4,r0
        0x1000230a:    4619        .F      MOV      r1,r3
        0x1000230c:    f7fffff0    ....    BL       __aeabi_memset ; 0x100022f0
        0x10002310:    4620         F      MOV      r0,r4
        0x10002312:    bd10        ..      POP      {r4,pc}
    .text
    __aeabi_uldivmod
        0x10002314:    e92d5ff0    -.._    PUSH     {r4-r12,lr}
        0x10002318:    4605        .F      MOV      r5,r0
        0x1000231a:    2000        .       MOVS     r0,#0
        0x1000231c:    4692        .F      MOV      r10,r2
        0x1000231e:    469b        .F      MOV      r11,r3
        0x10002320:    4688        .F      MOV      r8,r1
        0x10002322:    4606        .F      MOV      r6,r0
        0x10002324:    4681        .F      MOV      r9,r0
        0x10002326:    2440        @$      MOVS     r4,#0x40
        0x10002328:    e01b        ..      B        0x10002362 ; __aeabi_uldivmod + 78
        0x1000232a:    4628        (F      MOV      r0,r5
        0x1000232c:    4641        AF      MOV      r1,r8
        0x1000232e:    4647        GF      MOV      r7,r8
        0x10002330:    4622        "F      MOV      r2,r4
        0x10002332:    f000f82f    ../.    BL       __aeabi_llsr ; 0x10002394
        0x10002336:    4653        SF      MOV      r3,r10
        0x10002338:    465a        ZF      MOV      r2,r11
        0x1000233a:    1ac0        ..      SUBS     r0,r0,r3
        0x1000233c:    4191        .A      SBCS     r1,r1,r2
        0x1000233e:    d310        ..      BCC      0x10002362 ; __aeabi_uldivmod + 78
        0x10002340:    4611        .F      MOV      r1,r2
        0x10002342:    4618        .F      MOV      r0,r3
        0x10002344:    4622        "F      MOV      r2,r4
        0x10002346:    f000f816    ....    BL       __aeabi_llsl ; 0x10002376
        0x1000234a:    1a2d        -.      SUBS     r5,r5,r0
        0x1000234c:    eb670801    g...    SBC      r8,r7,r1
        0x10002350:    464f        OF      MOV      r7,r9
        0x10002352:    4622        "F      MOV      r2,r4
        0x10002354:    2001        .       MOVS     r0,#1
        0x10002356:    2100        .!      MOVS     r1,#0
        0x10002358:    f000f80d    ....    BL       __aeabi_llsl ; 0x10002376
        0x1000235c:    eb170900    ....    ADDS     r9,r7,r0
        0x10002360:    414e        NA      ADCS     r6,r6,r1
        0x10002362:    1e20         .      SUBS     r0,r4,#0
        0x10002364:    f1a40401    ....    SUB      r4,r4,#1
        0x10002368:    dcdf        ..      BGT      0x1000232a ; __aeabi_uldivmod + 22
        0x1000236a:    4648        HF      MOV      r0,r9
        0x1000236c:    4631        1F      MOV      r1,r6
        0x1000236e:    462a        *F      MOV      r2,r5
        0x10002370:    4643        CF      MOV      r3,r8
        0x10002372:    e8bd9ff0    ....    POP      {r4-r12,pc}
    .text
    __aeabi_llsl
    _ll_shift_l
        0x10002376:    2a20         *      CMP      r2,#0x20
        0x10002378:    db04        ..      BLT      0x10002384 ; __aeabi_llsl + 14
        0x1000237a:    3a20         :      SUBS     r2,r2,#0x20
        0x1000237c:    fa00f102    ....    LSL      r1,r0,r2
        0x10002380:    2000        .       MOVS     r0,#0
        0x10002382:    4770        pG      BX       lr
        0x10002384:    4091        .@      LSLS     r1,r1,r2
        0x10002386:    f1c20320    .. .    RSB      r3,r2,#0x20
        0x1000238a:    fa20f303     ...    LSR      r3,r0,r3
        0x1000238e:    4319        .C      ORRS     r1,r1,r3
        0x10002390:    4090        .@      LSLS     r0,r0,r2
        0x10002392:    4770        pG      BX       lr
    .text
    __aeabi_llsr
    _ll_ushift_r
        0x10002394:    2a20         *      CMP      r2,#0x20
        0x10002396:    db04        ..      BLT      0x100023a2 ; __aeabi_llsr + 14
        0x10002398:    3a20         :      SUBS     r2,r2,#0x20
        0x1000239a:    fa21f002    !...    LSR      r0,r1,r2
        0x1000239e:    2100        .!      MOVS     r1,#0
        0x100023a0:    4770        pG      BX       lr
        0x100023a2:    fa21f302    !...    LSR      r3,r1,r2
        0x100023a6:    40d0        .@      LSRS     r0,r0,r2
        0x100023a8:    f1c20220    .. .    RSB      r2,r2,#0x20
        0x100023ac:    4091        .@      LSLS     r1,r1,r2
        0x100023ae:    4308        .C      ORRS     r0,r0,r1
        0x100023b0:    4619        .F      MOV      r1,r3
        0x100023b2:    4770        pG      BX       lr
    HardFault_Handler_Proc
        0x100023b4:    b082        ..      SUB      sp,sp,#8
        0x100023b6:    f64e5728    N.(W    MOV      r7,#0xed28
        0x100023ba:    4615        .F      MOV      r5,r2
        0x100023bc:    460c        .F      MOV      r4,r1
        0x100023be:    4606        .F      MOV      r6,r0
        0x100023c0:    f2ce0700    ....    MOVT     r7,#0xe000
        0x100023c4:    f000fbe0    ....    BL       app_debug_reinit ; 0x10002b88
        0x100023c8:    f24340b0    C..@    MOV      r0,#0x34b0
        0x100023cc:    f3ef8108    ....    MRS      r1,MSP
        0x100023d0:    f2c10000    ....    MOVT     r0,#0x1000
        0x100023d4:    f000fd80    ....    BL       __0printf$8 ; 0x10002ed8
        0x100023d8:    0730        0.      LSLS     r0,r6,#28
        0x100023da:    f64300f5    C...    MOV      r0,#0x38f5
        0x100023de:    f6431114    C...    MOV      r1,#0x3914
        0x100023e2:    f2c10000    ....    MOVT     r0,#0x1000
        0x100023e6:    f2c10100    ....    MOVT     r1,#0x1000
        0x100023ea:    bf58        X.      IT       PL
        0x100023ec:    4608        .F      MOVPL    r0,r1
        0x100023ee:    f000ffb7    ....    BL       puts ; 0x10003360
        0x100023f2:    f0160004    ....    ANDS     r0,r6,#4
        0x100023f6:    f6431106    C...    MOV      r1,#0x3906
        0x100023fa:    a092        ..      ADR      r0,{pc}+0x24a ; 0x10002644
        0x100023fc:    f2c10100    ....    MOVT     r1,#0x1000
        0x10002400:    bf0c        ..      ITE      EQ
        0x10002402:    4608        .F      MOVEQ    r0,r1
        0x10002404:    462c        ,F      MOVNE    r4,r5
        0x10002406:    f000ffab    ....    BL       puts ; 0x10003360
        0x1000240a:    a092        ..      ADR      r0,{pc}+0x24a ; 0x10002654
        0x1000240c:    f000ffa8    ....    BL       puts ; 0x10003360
        0x10002410:    6821        !h      LDR      r1,[r4,#0]
        0x10002412:    a094        ..      ADR      r0,{pc}+0x252 ; 0x10002664
        0x10002414:    f000fd60    ..`.    BL       __0printf$8 ; 0x10002ed8
        0x10002418:    6861        ah      LDR      r1,[r4,#4]
        0x1000241a:    a096        ..      ADR      r0,{pc}+0x25a ; 0x10002674
        0x1000241c:    f000fd5c    ..\.    BL       __0printf$8 ; 0x10002ed8
        0x10002420:    68a1        .h      LDR      r1,[r4,#8]
        0x10002422:    a098        ..      ADR      r0,{pc}+0x262 ; 0x10002684
        0x10002424:    f000fd58    ..X.    BL       __0printf$8 ; 0x10002ed8
        0x10002428:    68e1        .h      LDR      r1,[r4,#0xc]
        0x1000242a:    a09a        ..      ADR      r0,{pc}+0x26a ; 0x10002694
        0x1000242c:    f000fd54    ..T.    BL       __0printf$8 ; 0x10002ed8
        0x10002430:    6921        !i      LDR      r1,[r4,#0x10]
        0x10002432:    a09c        ..      ADR      r0,{pc}+0x272 ; 0x100026a4
        0x10002434:    f000fd50    ..P.    BL       __0printf$8 ; 0x10002ed8
        0x10002438:    6961        ai      LDR      r1,[r4,#0x14]
        0x1000243a:    a09e        ..      ADR      r0,{pc}+0x27a ; 0x100026b4
        0x1000243c:    f000fd4c    ..L.    BL       __0printf$8 ; 0x10002ed8
        0x10002440:    69a1        .i      LDR      r1,[r4,#0x18]
        0x10002442:    a0a0        ..      ADR      r0,{pc}+0x282 ; 0x100026c4
        0x10002444:    f000fd48    ..H.    BL       __0printf$8 ; 0x10002ed8
        0x10002448:    69e1        .i      LDR      r1,[r4,#0x1c]
        0x1000244a:    a0a2        ..      ADR      r0,{pc}+0x28a ; 0x100026d4
        0x1000244c:    f000fd44    ..D.    BL       __0printf$8 ; 0x10002ed8
        0x10002450:    69a0        .i      LDR      r0,[r4,#0x18]
        0x10002452:    9001        ..      STR      r0,[sp,#4]
        0x10002454:    6878        xh      LDR      r0,[r7,#4]
        0x10002456:    0780        ..      LSLS     r0,r0,#30
        0x10002458:    d505        ..      BPL      0x10002466 ; HardFault_Handler_Proc + 178
        0x1000245a:    f64300c9    C...    MOV      r0,#0x38c9
        0x1000245e:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002462:    f000ff7d    ..}.    BL       puts ; 0x10003360
        0x10002466:    6878        xh      LDR      r0,[r7,#4]
        0x10002468:    f1b03fff    ...?    CMP      r0,#0xffffffff
        0x1000246c:    dc05        ..      BGT      0x1000247a ; HardFault_Handler_Proc + 198
        0x1000246e:    f64300e2    C...    MOV      r0,#0x38e2
        0x10002472:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002476:    f000ff73    ..s.    BL       puts ; 0x10003360
        0x1000247a:    6878        xh      LDR      r0,[r7,#4]
        0x1000247c:    0040        @.      LSLS     r0,r0,#1
        0x1000247e:    f14080dc    @...    BPL.W    0x1000263a ; HardFault_Handler_Proc + 646
        0x10002482:    f64300b5    C...    MOV      r0,#0x38b5
        0x10002486:    f2c10000    ....    MOVT     r0,#0x1000
        0x1000248a:    f000ff69    ..i.    BL       puts ; 0x10003360
        0x1000248e:    6838        8h      LDR      r0,[r7,#0]
        0x10002490:    0600        ..      LSLS     r0,r0,#24
        0x10002492:    d03e        >.      BEQ      0x10002512 ; HardFault_Handler_Proc + 350
        0x10002494:    f6430097    C...    MOV      r0,#0x3897
        0x10002498:    f2c10000    ....    MOVT     r0,#0x1000
        0x1000249c:    f000ff60    ..`.    BL       puts ; 0x10003360
        0x100024a0:    6838        8h      LDR      r0,[r7,#0]
        0x100024a2:    07c0        ..      LSLS     r0,r0,#31
        0x100024a4:    d006        ..      BEQ      0x100024b4 ; HardFault_Handler_Proc + 256
        0x100024a6:    9901        ..      LDR      r1,[sp,#4]
        0x100024a8:    f243402e    C..@    MOV      r0,#0x342e
        0x100024ac:    f2c10000    ....    MOVT     r0,#0x1000
        0x100024b0:    f000fd12    ....    BL       __0printf$8 ; 0x10002ed8
        0x100024b4:    6838        8h      LDR      r0,[r7,#0]
        0x100024b6:    0780        ..      LSLS     r0,r0,#30
        0x100024b8:    d510        ..      BPL      0x100024dc ; HardFault_Handler_Proc + 296
        0x100024ba:    9901        ..      LDR      r1,[sp,#4]
        0x100024bc:    f24330bb    C..0    MOV      r0,#0x33bb
        0x100024c0:    f2c10000    ....    MOVT     r0,#0x1000
        0x100024c4:    f000fd08    ....    BL       __0printf$8 ; 0x10002ed8
        0x100024c8:    6838        8h      LDR      r0,[r7,#0]
        0x100024ca:    0600        ..      LSLS     r0,r0,#24
        0x100024cc:    d506        ..      BPL      0x100024dc ; HardFault_Handler_Proc + 296
        0x100024ce:    68f9        .h      LDR      r1,[r7,#0xc]
        0x100024d0:    f24340a3    C..@    MOV      r0,#0x34a3
        0x100024d4:    f2c10000    ....    MOVT     r0,#0x1000
        0x100024d8:    f000fcfe    ....    BL       __0printf$8 ; 0x10002ed8
        0x100024dc:    6838        8h      LDR      r0,[r7,#0]
        0x100024de:    0700        ..      LSLS     r0,r0,#28
        0x100024e0:    d505        ..      BPL      0x100024ee ; HardFault_Handler_Proc + 314
        0x100024e2:    f2437059    C.Yp    MOV      r0,#0x3759
        0x100024e6:    f2c10000    ....    MOVT     r0,#0x1000
        0x100024ea:    f000ff39    ..9.    BL       puts ; 0x10003360
        0x100024ee:    6838        8h      LDR      r0,[r7,#0]
        0x100024f0:    06c0        ..      LSLS     r0,r0,#27
        0x100024f2:    d505        ..      BPL      0x10002500 ; HardFault_Handler_Proc + 332
        0x100024f4:    f24370ae    C..p    MOV      r0,#0x37ae
        0x100024f8:    f2c10000    ....    MOVT     r0,#0x1000
        0x100024fc:    f000ff30    ..0.    BL       puts ; 0x10003360
        0x10002500:    6838        8h      LDR      r0,[r7,#0]
        0x10002502:    0680        ..      LSLS     r0,r0,#26
        0x10002504:    d505        ..      BPL      0x10002512 ; HardFault_Handler_Proc + 350
        0x10002506:    f24360ba    C..`    MOV      r0,#0x36ba
        0x1000250a:    f2c10000    ....    MOVT     r0,#0x1000
        0x1000250e:    f000ff27    ..'.    BL       puts ; 0x10003360
        0x10002512:    6838        8h      LDR      r0,[r7,#0]
        0x10002514:    f4104f7f    ...O    TST      r0,#0xff00
        0x10002518:    d046        F.      BEQ      0x100025a8 ; HardFault_Handler_Proc + 500
        0x1000251a:    f64300d7    C...    MOV      r0,#0x38d7
        0x1000251e:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002522:    f000ff1d    ....    BL       puts ; 0x10003360
        0x10002526:    6838        8h      LDR      r0,[r7,#0]
        0x10002528:    05c0        ..      LSLS     r0,r0,#23
        0x1000252a:    d505        ..      BPL      0x10002538 ; HardFault_Handler_Proc + 388
        0x1000252c:    f24350e4    C..P    MOV      r0,#0x35e4
        0x10002530:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002534:    f000ff14    ....    BL       puts ; 0x10003360
        0x10002538:    6838        8h      LDR      r0,[r7,#0]
        0x1000253a:    0580        ..      LSLS     r0,r0,#22
        0x1000253c:    d510        ..      BPL      0x10002560 ; HardFault_Handler_Proc + 428
        0x1000253e:    9901        ..      LDR      r1,[sp,#4]
        0x10002540:    f2433084    C..0    MOV      r0,#0x3384
        0x10002544:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002548:    f000fcc6    ....    BL       __0printf$8 ; 0x10002ed8
        0x1000254c:    6838        8h      LDR      r0,[r7,#0]
        0x1000254e:    0400        ..      LSLS     r0,r0,#16
        0x10002550:    d506        ..      BPL      0x10002560 ; HardFault_Handler_Proc + 428
        0x10002552:    6939        9i      LDR      r1,[r7,#0x10]
        0x10002554:    f24340a3    C..@    MOV      r0,#0x34a3
        0x10002558:    f2c10000    ....    MOVT     r0,#0x1000
        0x1000255c:    f000fcbc    ....    BL       __0printf$8 ; 0x10002ed8
        0x10002560:    6838        8h      LDR      r0,[r7,#0]
        0x10002562:    0540        @.      LSLS     r0,r0,#21
        0x10002564:    d505        ..      BPL      0x10002572 ; HardFault_Handler_Proc + 446
        0x10002566:    f243507a    C.zP    MOV      r0,#0x357a
        0x1000256a:    f2c10000    ....    MOVT     r0,#0x1000
        0x1000256e:    f000fef7    ....    BL       puts ; 0x10003360
        0x10002572:    6838        8h      LDR      r0,[r7,#0]
        0x10002574:    0500        ..      LSLS     r0,r0,#20
        0x10002576:    d505        ..      BPL      0x10002584 ; HardFault_Handler_Proc + 464
        0x10002578:    f6430001    C...    MOV      r0,#0x3801
        0x1000257c:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002580:    f000feee    ....    BL       puts ; 0x10003360
        0x10002584:    6838        8h      LDR      r0,[r7,#0]
        0x10002586:    04c0        ..      LSLS     r0,r0,#19
        0x10002588:    d505        ..      BPL      0x10002596 ; HardFault_Handler_Proc + 482
        0x1000258a:    f643004d    C.M.    MOV      r0,#0x384d
        0x1000258e:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002592:    f000fee5    ....    BL       puts ; 0x10003360
        0x10002596:    6838        8h      LDR      r0,[r7,#0]
        0x10002598:    0480        ..      LSLS     r0,r0,#18
        0x1000259a:    d505        ..      BPL      0x100025a8 ; HardFault_Handler_Proc + 500
        0x1000259c:    f243700d    C..p    MOV      r0,#0x370d
        0x100025a0:    f2c10000    ....    MOVT     r0,#0x1000
        0x100025a4:    f000fedc    ....    BL       puts ; 0x10003360
        0x100025a8:    6838        8h      LDR      r0,[r7,#0]
        0x100025aa:    f5b03f80    ...?    CMP      r0,#0x10000
        0x100025ae:    d344        D.      BCC      0x1000263a ; HardFault_Handler_Proc + 646
        0x100025b0:    f64300a8    C...    MOV      r0,#0x38a8
        0x100025b4:    f2c10000    ....    MOVT     r0,#0x1000
        0x100025b8:    f000fed2    ....    BL       puts ; 0x10003360
        0x100025bc:    6838        8h      LDR      r0,[r7,#0]
        0x100025be:    03c0        ..      LSLS     r0,r0,#15
        0x100025c0:    d505        ..      BPL      0x100025ce ; HardFault_Handler_Proc + 538
        0x100025c2:    f2435006    C..P    MOV      r0,#0x3506
        0x100025c6:    f2c10000    ....    MOVT     r0,#0x1000
        0x100025ca:    f000fec9    ....    BL       puts ; 0x10003360
        0x100025ce:    6838        8h      LDR      r0,[r7,#0]
        0x100025d0:    0380        ..      LSLS     r0,r0,#14
        0x100025d2:    d505        ..      BPL      0x100025e0 ; HardFault_Handler_Proc + 556
        0x100025d4:    f243607d    C.}`    MOV      r0,#0x367d
        0x100025d8:    f2c10000    ....    MOVT     r0,#0x1000
        0x100025dc:    f000fec0    ....    BL       puts ; 0x10003360
        0x100025e0:    6838        8h      LDR      r0,[r7,#0]
        0x100025e2:    0340        @.      LSLS     r0,r0,#13
        0x100025e4:    d505        ..      BPL      0x100025f2 ; HardFault_Handler_Proc + 574
        0x100025e6:    f24340d8    C..@    MOV      r0,#0x34d8
        0x100025ea:    f2c10000    ....    MOVT     r0,#0x1000
        0x100025ee:    f000feb7    ....    BL       puts ; 0x10003360
        0x100025f2:    6838        8h      LDR      r0,[r7,#0]
        0x100025f4:    0300        ..      LSLS     r0,r0,#12
        0x100025f6:    d505        ..      BPL      0x10002604 ; HardFault_Handler_Proc + 592
        0x100025f8:    f2436011    C..`    MOV      r0,#0x3611
        0x100025fc:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002600:    f000feae    ....    BL       puts ; 0x10003360
        0x10002604:    6838        8h      LDR      r0,[r7,#0]
        0x10002606:    02c0        ..      LSLS     r0,r0,#11
        0x10002608:    d505        ..      BPL      0x10002616 ; HardFault_Handler_Proc + 610
        0x1000260a:    f2436051    C.Q`    MOV      r0,#0x3651
        0x1000260e:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002612:    f000fea5    ....    BL       puts ; 0x10003360
        0x10002616:    6838        8h      LDR      r0,[r7,#0]
        0x10002618:    01c0        ..      LSLS     r0,r0,#7
        0x1000261a:    d505        ..      BPL      0x10002628 ; HardFault_Handler_Proc + 628
        0x1000261c:    f24350b1    C..P    MOV      r0,#0x35b1
        0x10002620:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002624:    f000fe9c    ....    BL       puts ; 0x10003360
        0x10002628:    6838        8h      LDR      r0,[r7,#0]
        0x1000262a:    0180        ..      LSLS     r0,r0,#6
        0x1000262c:    d505        ..      BPL      0x1000263a ; HardFault_Handler_Proc + 646
        0x1000262e:    f243503f    C.?P    MOV      r0,#0x353f
        0x10002632:    f2c10000    ....    MOVT     r0,#0x1000
        0x10002636:    f000fe93    ....    BL       puts ; 0x10003360
        0x1000263a:    f000fa77    ..w.    BL       app_debug_printf ; 0x10002b2c
        0x1000263e:    bf00        ..      NOP      
        0x10002640:    e7fe        ..      B        0x10002640 ; HardFault_Handler_Proc + 652
        0x10002642:    bf00        ..      NOP      
    $d
        0x10002644:    6e697355    Usin    DCD    1852404565
        0x10002648:    33752067    g u3    DCD    863314023
        0x1000264c:    70735032    2Psp    DCD    1886605362
        0x10002650:    0000002e    ....    DCD    46
        0x10002654:    63617453    Stac    DCD    1667331155
        0x10002658:    7266206b    k fr    DCD    1919295595
        0x1000265c:    3a656d61    ame:    DCD    979725665
        0x10002660:    00000000    ....    DCD    0
        0x10002664:    20203052    R0      DCD    538980434
        0x10002668:    7830203a    : 0x    DCD    2016419898
        0x1000266c:    58383025    %08X    DCD    1480077349
        0x10002670:    0000000a    ....    DCD    10
        0x10002674:    20203152    R1      DCD    538980690
        0x10002678:    7830203a    : 0x    DCD    2016419898
        0x1000267c:    58383025    %08X    DCD    1480077349
        0x10002680:    0000000a    ....    DCD    10
        0x10002684:    20203252    R2      DCD    538980946
        0x10002688:    7830203a    : 0x    DCD    2016419898
        0x1000268c:    58383025    %08X    DCD    1480077349
        0x10002690:    0000000a    ....    DCD    10
        0x10002694:    20203352    R3      DCD    538981202
        0x10002698:    7830203a    : 0x    DCD    2016419898
        0x1000269c:    58383025    %08X    DCD    1480077349
        0x100026a0:    0000000a    ....    DCD    10
        0x100026a4:    20323152    R12     DCD    540160338
        0x100026a8:    7830203a    : 0x    DCD    2016419898
        0x100026ac:    58383025    %08X    DCD    1480077349
        0x100026b0:    0000000a    ....    DCD    10
        0x100026b4:    2020524c    LR      DCD    538989132
        0x100026b8:    7830203a    : 0x    DCD    2016419898
        0x100026bc:    58383025    %08X    DCD    1480077349
        0x100026c0:    0000000a    ....    DCD    10
        0x100026c4:    20204350    PC      DCD    538985296
        0x100026c8:    7830203a    : 0x    DCD    2016419898
        0x100026cc:    58383025    %08X    DCD    1480077349
        0x100026d0:    0000000a    ....    DCD    10
        0x100026d4:    52535078    xPSR    DCD    1381191800
        0x100026d8:    7830203a    : 0x    DCD    2016419898
        0x100026dc:    58383025    %08X    DCD    1480077349
        0x100026e0:    0000000a    ....    DCD    10
    $t
    I2S_AcquireReadyBuffer
        0x100026e4:    b168        h.      CBZ      r0,0x10002702 ; I2S_AcquireReadyBuffer + 30
        0x100026e6:    f24d0c48    M.H.    MOV      r12,#0xd048
        0x100026ea:    f2c20c00    ....    MOVT     r12,#0x2000
        0x100026ee:    f89c3000    ...0    LDRB     r3,[r12,#0]
        0x100026f2:    07da        ..      LSLS     r2,r3,#31
        0x100026f4:    f24b021c    K...    MOV      r2,#0xb01c
        0x100026f8:    f2c20200    ....    MOVT     r2,#0x2000
        0x100026fc:    d103        ..      BNE      0x10002706 ; I2S_AcquireReadyBuffer + 34
        0x100026fe:    079b        ..      LSLS     r3,r3,#30
        0x10002700:    d403        ..      BMI      0x1000270a ; I2S_AcquireReadyBuffer + 38
        0x10002702:    2000        .       MOVS     r0,#0
        0x10002704:    4770        pG      BX       lr
        0x10002706:    23fe        .#      MOVS     r3,#0xfe
        0x10002708:    e002        ..      B        0x10002710 ; I2S_AcquireReadyBuffer + 44
        0x1000270a:    f5025280    ...R    ADD      r2,r2,#0x1000
        0x1000270e:    23fd        .#      MOVS     r3,#0xfd
        0x10002710:    f89c1000    ....    LDRB     r1,[r12,#0]
        0x10002714:    4019        .@      ANDS     r1,r1,r3
        0x10002716:    f88c1000    ....    STRB     r1,[r12,#0]
        0x1000271a:    6002        .`      STR      r2,[r0,#0]
        0x1000271c:    2001        .       MOVS     r0,#1
        0x1000271e:    4770        pG      BX       lr
    I2S_GetRxSampleCount
        0x10002720:    f44f6080    O..`    MOV      r0,#0x400
        0x10002724:    4770        pG      BX       lr
        0x10002726:    0000        ..      MOVS     r0,r0
    I2S_MasterRx_Init
        0x10002728:    b5f0        ..      PUSH     {r4-r7,lr}
        0x1000272a:    b081        ..      SUB      sp,sp,#4
        0x1000272c:    f24b0480    K...    MOV      r4,#0xb080
        0x10002730:    f2c60404    ....    MOVT     r4,#0x6004
        0x10002734:    4620         F      MOV      r0,r4
        0x10002736:    2101        .!      MOVS     r1,#1
        0x10002738:    2222        ""      MOVS     r2,#0x22
        0x1000273a:    f000fb2c    ..,.    BL       $Ven$TT$L$$rom_hw_gpio_set_pin_pid ; 0x10002d96
        0x1000273e:    f24d071c    M...    MOV      r7,#0xd01c
        0x10002742:    f2c60702    ....    MOVT     r7,#0x6002
        0x10002746:    f50730ee    ...0    ADD      r0,r7,#0x1dc00
        0x1000274a:    f5007579    ..yu    ADD      r5,r0,#0x3e4
        0x1000274e:    4628        (F      MOV      r0,r5
        0x10002750:    f44f7100    O..q    MOV      r1,#0x200
        0x10002754:    2221        !"      MOVS     r2,#0x21
        0x10002756:    f000fb1e    ....    BL       $Ven$TT$L$$rom_hw_gpio_set_pin_pid ; 0x10002d96
        0x1000275a:    4628        (F      MOV      r0,r5
        0x1000275c:    f44f1100    O...    MOV      r1,#0x200000
        0x10002760:    2223        #"      MOVS     r2,#0x23
        0x10002762:    f000fb18    ....    BL       $Ven$TT$L$$rom_hw_gpio_set_pin_pid ; 0x10002d96
        0x10002766:    4620         F      MOV      r0,r4
        0x10002768:    f44f6100    O..a    MOV      r1,#0x800
        0x1000276c:    2200        ."      MOVS     r2,#0
        0x1000276e:    2600        .&      MOVS     r6,#0
        0x10002770:    f000fb11    ....    BL       $Ven$TT$L$$rom_hw_gpio_set_pin_pid ; 0x10002d96
        0x10002774:    4620         F      MOV      r0,r4
        0x10002776:    f44f6100    O..a    MOV      r1,#0x800
        0x1000277a:    2201        ."      MOVS     r2,#1
        0x1000277c:    f000fb10    ....    BL       $Ven$TT$L$$rom_hw_gpio_set_pin_input_output ; 0x10002da0
        0x10002780:    4620         F      MOV      r0,r4
        0x10002782:    f44f6100    O..a    MOV      r1,#0x800
        0x10002786:    2203        ."      MOVS     r2,#3
        0x10002788:    f000fb0f    ....    BL       $Ven$TT$L$$rom_hw_gpio_set_pin_drive_strength ; 0x10002daa
        0x1000278c:    4620         F      MOV      r0,r4
        0x1000278e:    f44f6100    O..a    MOV      r1,#0x800
        0x10002792:    2201        ."      MOVS     r2,#1
        0x10002794:    f000fb0e    ....    BL       $Ven$TT$L$$rom_hw_gpio_set_pin_output_level ; 0x10002db4
        0x10002798:    2014        .       MOVS     r0,#0x14
        0x1000279a:    f000fb10    ....    BL       $Ven$TT$L$$rom_delay_ms ; 0x10002dbe
        0x1000279e:    f24b041c    K...    MOV      r4,#0xb01c
        0x100027a2:    f2c20400    ....    MOVT     r4,#0x2000
        0x100027a6:    4620         F      MOV      r0,r4
        0x100027a8:    f44f5100    O..Q    MOV      r1,#0x2000
        0x100027ac:    f7fffda7    ....    BL       __aeabi_memclr ; 0x100022fe
        0x100027b0:    f24d0524    M.$.    MOV      r5,#0xd024
        0x100027b4:    f24d0020    M. .    MOV      r0,#0xd020
        0x100027b8:    f2c20500    ....    MOVT     r5,#0x2000
        0x100027bc:    f2c20000    ....    MOVT     r0,#0x2000
        0x100027c0:    e9c56600    ...f    STRD     r6,r6,[r5,#0]
        0x100027c4:    e9c56602    ...f    STRD     r6,r6,[r5,#8]
        0x100027c8:    612e        .a      STR      r6,[r5,#0x10]
        0x100027ca:    7006        .p      STRB     r6,[r0,#0]
        0x100027cc:    f24d0048    M.H.    MOV      r0,#0xd048
        0x100027d0:    f2c20000    ....    MOVT     r0,#0x2000
        0x100027d4:    7006        .p      STRB     r6,[r0,#0]
        0x100027d6:    f24d0044    M.D.    MOV      r0,#0xd044
        0x100027da:    f2c20000    ....    MOVT     r0,#0x2000
        0x100027de:    6006        .`      STR      r6,[r0,#0]
        0x100027e0:    2016        .       MOVS     r0,#0x16
        0x100027e2:    f000faf1    ....    BL       $Ven$TT$L$$rom_hw_crg_enable_clk_gate ; 0x10002dc8
        0x100027e6:    200f        .       MOVS     r0,#0xf
        0x100027e8:    f000faf3    ....    BL       $Ven$TT$L$$rom_hw_crg_keep_reset ; 0x10002dd2
        0x100027ec:    200f        .       MOVS     r0,#0xf
        0x100027ee:    f000faf5    ....    BL       $Ven$TT$L$$rom_hw_crg_release_reset ; 0x10002ddc
        0x100027f2:    2004        .       MOVS     r0,#4
        0x100027f4:    f000faf7    ....    BL       $Ven$TT$L$$rom_hw_crg_set_i2s_bclk_divisor ; 0x10002de6
        0x100027f8:    f000faa8    ....    BL       rom_hw_i2s_deinit ; 0x10002d4c
        0x100027fc:    f24030ff    @..0    MOV      r0,#0x3ff
        0x10002800:    f000fa94    ....    BL       rom_hw_i2s_clear_interrupt_flag ; 0x10002d2c
        0x10002804:    f64140f4    A..@    MOV      r0,#0x1cf4
        0x10002808:    f000fab0    ....    BL       rom_hw_i2s_init ; 0x10002d6c
        0x1000280c:    2004        .       MOVS     r0,#4
        0x1000280e:    f000faef    ....    BL       $Ven$TT$L$$rom_delay_us ; 0x10002df0
        0x10002812:    2020                MOVS     r0,#0x20
        0x10002814:    f000fab4    ....    BL       rom_hw_i2s_set_wclk_freq ; 0x10002d80
        0x10002818:    2017        .       MOVS     r0,#0x17
        0x1000281a:    f000fad5    ....    BL       $Ven$TT$L$$rom_hw_crg_enable_clk_gate ; 0x10002dc8
        0x1000281e:    2001        .       MOVS     r0,#1
        0x10002820:    2111        .!      MOVS     r1,#0x11
        0x10002822:    f000faea    ....    BL       $Ven$TT$L$$rom_hw_sys_ctrl_enable_peri_int ; 0x10002dfa
        0x10002826:    f24e1000    N...    MOVW     r0,#0xe100
        0x1000282a:    f24e4211    N..B    MOV      r2,#0xe411
        0x1000282e:    f2ce0000    ....    MOVT     r0,#0xe000
        0x10002832:    f44f3100    O..1    MOV      r1,#0x20000
        0x10002836:    f2ce0200    ....    MOVT     r2,#0xe000
        0x1000283a:    2360        `#      MOVS     r3,#0x60
        0x1000283c:    f8c01180    ....    STR      r1,[r0,#0x180]
        0x10002840:    7013        .p      STRB     r3,[r2,#0]
        0x10002842:    6001        .`      STR      r1,[r0,#0]
        0x10002844:    f1a7001c    ....    SUB      r0,r7,#0x1c
        0x10002848:    e9c50400    ....    STRD     r0,r4,[r5,#0]
        0x1000284c:    f2404000    @..@    MOVW     r0,#0x400
        0x10002850:    f2480600    H...    MOVW     r6,#0x8000
        0x10002854:    f44f717a    O.zq    MOV      r1,#0x3e8
        0x10002858:    f2c01069    ..i.    MOVT     r0,#0x169
        0x1000285c:    f2c50600    ....    MOVT     r6,#0x5000
        0x10002860:    2227        '"      MOVS     r2,#0x27
        0x10002862:    e9c51002    ....    STRD     r1,r0,[r5,#8]
        0x10002866:    4630        0F      MOV      r0,r6
        0x10002868:    742a        *t      STRB     r2,[r5,#0x10]
        0x1000286a:    f000facb    ....    BL       $Ven$TT$L$$rom_hw_dma_disable ; 0x10002e04
        0x1000286e:    4630        0F      MOV      r0,r6
        0x10002870:    4629        )F      MOV      r1,r5
        0x10002872:    606c        l`      STR      r4,[r5,#4]
        0x10002874:    f000facb    ....    BL       $Ven$TT$L$$rom_hw_dma_init ; 0x10002e0e
        0x10002878:    4630        0F      MOV      r0,r6
        0x1000287a:    2100        .!      MOVS     r1,#0
        0x1000287c:    f000facc    ....    BL       $Ven$TT$L$$rom_hw_dma_set_interrupt_channel ; 0x10002e18
        0x10002880:    4630        0F      MOV      r0,r6
        0x10002882:    2102        .!      MOVS     r1,#2
        0x10002884:    f000facd    ....    BL       $Ven$TT$L$$rom_hw_dma_enable_interrupt ; 0x10002e22
        0x10002888:    4630        0F      MOV      r0,r6
        0x1000288a:    f000facf    ....    BL       $Ven$TT$L$$rom_hw_dma_enable ; 0x10002e2c
        0x1000288e:    6838        8h      LDR      r0,[r7,#0]
        0x10002890:    f4407080    @..p    ORR      r0,r0,#0x100
        0x10002894:    6038        8`      STR      r0,[r7,#0]
        0x10002896:    b001        ..      ADD      sp,sp,#4
        0x10002898:    bdf0        ..      POP      {r4-r7,pc}
        0x1000289a:    0000        ..      MOVS     r0,r0
    NMI_Handler_Proc
        0x1000289c:    4614        .F      MOV      r4,r2
        0x1000289e:    460d        .F      MOV      r5,r1
        0x100028a0:    4606        .F      MOV      r6,r0
        0x100028a2:    f000f971    ..q.    BL       app_debug_reinit ; 0x10002b88
        0x100028a6:    a005        ..      ADR      r0,{pc}+0x16 ; 0x100028bc
        0x100028a8:    4631        1F      MOV      r1,r6
        0x100028aa:    462a        *F      MOV      r2,r5
        0x100028ac:    4623        #F      MOV      r3,r4
        0x100028ae:    f000fb13    ....    BL       __0printf$8 ; 0x10002ed8
        0x100028b2:    f000f93b    ..;.    BL       app_debug_printf ; 0x10002b2c
        0x100028b6:    bf00        ..      NOP      
        0x100028b8:    e7fe        ..      B        0x100028b8 ; NMI_Handler_Proc + 28
        0x100028ba:    bf00        ..      NOP      
    $d
        0x100028bc:    5f494d4e    NMI_    DCD    1598639438
        0x100028c0:    646e6148    Hand    DCD    1684955464
        0x100028c4:    3a72656c    ler:    DCD    980575596
        0x100028c8:    38302520     %08    DCD    942679328
        0x100028cc:    25202c58    X, %    DCD    622865496
        0x100028d0:    2c583830    08X,    DCD    743979056
        0x100028d4:    38302520     %08    DCD    942679328
        0x100028d8:    00000a58    X...    DCD    2648
    $t
    SPH0645LM4H_Init
        0x100028dc:    f24d004c    M.L.    MOV      r0,#0xd04c
        0x100028e0:    f2c20000    ....    MOVT     r0,#0x2000
        0x100028e4:    2100        .!      MOVS     r1,#0
        0x100028e6:    6001        .`      STR      r1,[r0,#0]
        0x100028e8:    f24d003c    M.<.    MOV      r0,#0xd03c
        0x100028ec:    f2c20000    ....    MOVT     r0,#0x2000
        0x100028f0:    6001        .`      STR      r1,[r0,#0]
        0x100028f2:    f24d0038    M.8.    MOV      r0,#0xd038
        0x100028f6:    f2c20000    ....    MOVT     r0,#0x2000
        0x100028fa:    6001        .`      STR      r1,[r0,#0]
        0x100028fc:    f24d001c    M...    MOV      r0,#0xd01c
        0x10002900:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002904:    6001        .`      STR      r1,[r0,#0]
        0x10002906:    f24d0040    M.@.    MOV      r0,#0xd040
        0x1000290a:    f2c20000    ....    MOVT     r0,#0x2000
        0x1000290e:    6001        .`      STR      r1,[r0,#0]
        0x10002910:    4770        pG      BX       lr
        0x10002912:    0000        ..      MOVS     r0,r0
    SPH0645LM4H_ProcessBuffer
        0x10002914:    e92d4ff0    -..O    PUSH     {r4-r11,lr}
        0x10002918:    b085        ..      SUB      sp,sp,#0x14
        0x1000291a:    2800        .(      CMP      r0,#0
        0x1000291c:    9102        ..      STR      r1,[sp,#8]
        0x1000291e:    f00080b5    ....    BEQ.W    0x10002a8c ; SPH0645LM4H_ProcessBuffer + 376
        0x10002922:    4683        .F      MOV      r11,r0
        0x10002924:    9802        ..      LDR      r0,[sp,#8]
        0x10002926:    2802        .(      CMP      r0,#2
        0x10002928:    f0c080b0    ....    BCC.W    0x10002a8c ; SPH0645LM4H_ProcessBuffer + 376
        0x1000292c:    f10d080e    ....    ADD      r8,sp,#0xe
        0x10002930:    f2400e00    @...    MOVW     lr,#0
        0x10002934:    f24d063c    M.<.    MOV      r6,#0xd03c
        0x10002938:    f24d0738    M.8.    MOV      r7,#0xd038
        0x1000293c:    f24d054c    M.L.    MOV      r5,#0xd04c
        0x10002940:    f1a80a01    ....    SUB      r10,r8,#1
        0x10002944:    2401        .$      MOVS     r4,#1
        0x10002946:    f6cf7eff    ...~    MOVT     lr,#0xffff
        0x1000294a:    f2c20600    ....    MOVT     r6,#0x2000
        0x1000294e:    f6472c12    G..,    MOV      r12,#0x7a12
        0x10002952:    f2c20700    ....    MOVT     r7,#0x2000
        0x10002956:    f2c20500    ....    MOVT     r5,#0x2000
        0x1000295a:    f64c49cd    L..I    MOV      r9,#0xcccd
        0x1000295e:    f8cdb004    ....    STR      r11,[sp,#4]
        0x10002962:    e02a        *.      B        0x100029ba ; SPH0645LM4H_ProcessBuffer + 166
        0x10002964:    2030        0       MOVS     r0,#0x30
        0x10002966:    4629        )F      MOV      r1,r5
        0x10002968:    f000fcf7    ....    BL       putc ; 0x1000335a
        0x1000296c:    f8ddb004    ....    LDR      r11,[sp,#4]
        0x10002970:    200d        .       MOVS     r0,#0xd
        0x10002972:    4629        )F      MOV      r1,r5
        0x10002974:    f000fcf1    ....    BL       putc ; 0x1000335a
        0x10002978:    200a        .       MOVS     r0,#0xa
        0x1000297a:    4629        )F      MOV      r1,r5
        0x1000297c:    f000fced    ....    BL       putc ; 0x1000335a
        0x10002980:    f24d0140    M.@.    MOV      r1,#0xd040
        0x10002984:    f2c20100    ....    MOVT     r1,#0x2000
        0x10002988:    6808        .h      LDR      r0,[r1,#0]
        0x1000298a:    f2400e00    @...    MOVW     lr,#0
        0x1000298e:    f24d063c    M.<.    MOV      r6,#0xd03c
        0x10002992:    f24d0738    M.8.    MOV      r7,#0xd038
        0x10002996:    f24d054c    M.L.    MOV      r5,#0xd04c
        0x1000299a:    3001        .0      ADDS     r0,#1
        0x1000299c:    f6cf7eff    ...~    MOVT     lr,#0xffff
        0x100029a0:    f2c20600    ....    MOVT     r6,#0x2000
        0x100029a4:    f6472c12    G..,    MOV      r12,#0x7a12
        0x100029a8:    f2c20700    ....    MOVT     r7,#0x2000
        0x100029ac:    f2c20500    ....    MOVT     r5,#0x2000
        0x100029b0:    6008        .`      STR      r0,[r1,#0]
        0x100029b2:    9802        ..      LDR      r0,[sp,#8]
        0x100029b4:    3402        .4      ADDS     r4,#2
        0x100029b6:    4284        .B      CMP      r4,r0
        0x100029b8:    d268        h.      BCS      0x10002a8c ; SPH0645LM4H_ProcessBuffer + 376
        0x100029ba:    f85b0024    [.$.    LDR      r0,[r11,r4,LSL #2]
        0x100029be:    0c01        ..      LSRS     r1,r0,#16
        0x100029c0:    2800        .(      CMP      r0,#0
        0x100029c2:    bf48        H.      IT       MI
        0x100029c4:    ea4e4110    N..A    ORRMI    r1,lr,r0,LSR #16
        0x100029c8:    6830        0h      LDR      r0,[r6,#0]
        0x100029ca:    682a        *h      LDR      r2,[r5,#0]
        0x100029cc:    4408        .D      ADD      r0,r0,r1
        0x100029ce:    6839        9h      LDR      r1,[r7,#0]
        0x100029d0:    f50253fa    ...S    ADD      r3,r2,#0x1f40
        0x100029d4:    3101        .1      ADDS     r1,#1
        0x100029d6:    4563        cE      CMP      r3,r12
        0x100029d8:    6030        0`      STR      r0,[r6,#0]
        0x100029da:    6039        9`      STR      r1,[r7,#0]
        0x100029dc:    602b        +`      STR      r3,[r5,#0]
        0x100029de:    d3e8        ..      BCC      0x100029b2 ; SPH0645LM4H_ProcessBuffer + 158
        0x100029e0:    f64523d2    E..#    MOV      r3,#0x5ad2
        0x100029e4:    1ad2        ..      SUBS     r2,r2,r3
        0x100029e6:    602a        *`      STR      r2,[r5,#0]
        0x100029e8:    f24d051c    M...    MOV      r5,#0xd01c
        0x100029ec:    f2c20500    ....    MOVT     r5,#0x2000
        0x100029f0:    fb90f0f1    ....    SDIV     r0,r0,r1
        0x100029f4:    6829        )h      LDR      r1,[r5,#0]
        0x100029f6:    2300        .#      MOVS     r3,#0
        0x100029f8:    1a42        B.      SUBS     r2,r0,r1
        0x100029fa:    eb012122    .."!    ADD      r1,r1,r2,ASR #8
        0x100029fe:    6033        3`      STR      r3,[r6,#0]
        0x10002a00:    1a40        @.      SUBS     r0,r0,r1
        0x10002a02:    f3000b0f    ....    SSAT     r11,#16,r0
        0x10002a06:    6029        )`      STR      r1,[r5,#0]
        0x10002a08:    f24b0500    K...    MOVW     r5,#0xb000
        0x10002a0c:    f1b03fff    ...?    CMP      r0,#0xffffffff
        0x10002a10:    f2c20500    ....    MOVT     r5,#0x2000
        0x10002a14:    603b        ;`      STR      r3,[r7,#0]
        0x10002a16:    dd03        ..      BLE      0x10002a20 ; SPH0645LM4H_ProcessBuffer + 268
        0x10002a18:    ea5f400b    _..@    LSLS     r0,r11,#16
        0x10002a1c:    d109        ..      BNE      0x10002a32 ; SPH0645LM4H_ProcessBuffer + 286
        0x10002a1e:    e7a1        ..      B        0x10002964 ; SPH0645LM4H_ProcessBuffer + 80
        0x10002a20:    202d        -       MOVS     r0,#0x2d
        0x10002a22:    4629        )F      MOV      r1,r5
        0x10002a24:    f000fc99    ....    BL       putc ; 0x1000335a
        0x10002a28:    f1cb0b00    ....    RSB      r11,r11,#0
        0x10002a2c:    ea5f400b    _..@    LSLS     r0,r11,#16
        0x10002a30:    d098        ..      BEQ      0x10002964 ; SPH0645LM4H_ProcessBuffer + 80
        0x10002a32:    f8ddc004    ....    LDR      r12,[sp,#4]
        0x10002a36:    2000        .       MOVS     r0,#0
        0x10002a38:    2101        .!      MOVS     r1,#1
        0x10002a3a:    bf00        ..      NOP      
        0x10002a3c:    fa1ff68b    ....    UXTH     r6,r11
        0x10002a40:    fb06f209    ....    MUL      r2,r6,r9
        0x10002a44:    2e0a        ..      CMP      r6,#0xa
        0x10002a46:    ea4f47d2    O..G    LSR      r7,r2,#19
        0x10002a4a:    eb070287    ....    ADD      r2,r7,r7,LSL #2
        0x10002a4e:    ebab0342    ..B.    SUB      r3,r11,r2,LSL #1
        0x10002a52:    460a        .F      MOV      r2,r1
        0x10002a54:    f0430130    C.0.    ORR      r1,r3,#0x30
        0x10002a58:    f1000301    ....    ADD      r3,r0,#1
        0x10002a5c:    b2c0        ..      UXTB     r0,r0
        0x10002a5e:    f8081000    ....    STRB     r1,[r8,r0]
        0x10002a62:    f1020101    ....    ADD      r1,r2,#1
        0x10002a66:    4618        .F      MOV      r0,r3
        0x10002a68:    46bb        .F      MOV      r11,r7
        0x10002a6a:    d2e7        ..      BCS      0x10002a3c ; SPH0645LM4H_ProcessBuffer + 296
        0x10002a6c:    0618        ..      LSLS     r0,r3,#24
        0x10002a6e:    46e3        .F      MOV      r11,r12
        0x10002a70:    f43faf7e    ?.~.    BEQ      0x10002970 ; SPH0645LM4H_ProcessBuffer + 92
        0x10002a74:    b2d1        ..      UXTB     r1,r2
        0x10002a76:    bf00        ..      NOP      
        0x10002a78:    f81a0001    ....    LDRB     r0,[r10,r1]
        0x10002a7c:    1e4e        N.      SUBS     r6,r1,#1
        0x10002a7e:    4629        )F      MOV      r1,r5
        0x10002a80:    f000fc6b    ..k.    BL       putc ; 0x1000335a
        0x10002a84:    2e00        ..      CMP      r6,#0
        0x10002a86:    4631        1F      MOV      r1,r6
        0x10002a88:    d1f6        ..      BNE      0x10002a78 ; SPH0645LM4H_ProcessBuffer + 356
        0x10002a8a:    e771        q.      B        0x10002970 ; SPH0645LM4H_ProcessBuffer + 92
        0x10002a8c:    b005        ..      ADD      sp,sp,#0x14
        0x10002a8e:    e8bd8ff0    ....    POP      {r4-r11,pc}
        0x10002a92:    0000        ..      MOVS     r0,r0
    app_debug_init
        0x10002a94:    b510        ..      PUSH     {r4,lr}
        0x10002a96:    f8ddc008    ....    LDR      r12,[sp,#8]
        0x10002a9a:    f1b24fc0    ...O    CMP      r2,#0x60000000
        0x10002a9e:    d00b        ..      BEQ      0x10002ab8 ; app_debug_init + 36
        0x10002aa0:    f6400e00    @...    MOVW     lr,#0x800
        0x10002aa4:    f2c60e00    ....    MOVT     lr,#0x6000
        0x10002aa8:    4572        rE      CMP      r2,lr
        0x10002aaa:    d005        ..      BEQ      0x10002ab8 ; app_debug_init + 36
        0x10002aac:    f2404e00    @..N    MOVW     lr,#0x400
        0x10002ab0:    f2c60e00    ....    MOVT     lr,#0x6000
        0x10002ab4:    4572        rE      CMP      r2,lr
        0x10002ab6:    d136        6.      BNE      0x10002b26 ; app_debug_init + 146
        0x10002ab8:    f24b0480    K...    MOV      r4,#0xb080
        0x10002abc:    f0400e80    @...    ORR      lr,r0,#0x80
        0x10002ac0:    f2c60404    ....    MOVT     r4,#0x6004
        0x10002ac4:    45a6        .E      CMP      lr,r4
        0x10002ac6:    d12e        ..      BNE      0x10002b26 ; app_debug_init + 146
        0x10002ac8:    f24b0404    K...    MOV      r4,#0xb004
        0x10002acc:    f2c20400    ....    MOVT     r4,#0x2000
        0x10002ad0:    f1bc0f00    ....    CMP      r12,#0
        0x10002ad4:    f8c4c000    ....    STR      r12,[r4,#0]
        0x10002ad8:    d00d        ..      BEQ      0x10002af6 ; app_debug_init + 98
        0x10002ada:    f24b0c12    K...    MOV      r12,#0xb012
        0x10002ade:    f24b0410    K...    MOV      r4,#0xb010
        0x10002ae2:    f2c20c00    ....    MOVT     r12,#0x2000
        0x10002ae6:    f04f0e00    O...    MOV      lr,#0
        0x10002aea:    f2c20400    ....    MOVT     r4,#0x2000
        0x10002aee:    f8ace000    ....    STRH     lr,[r12,#0]
        0x10002af2:    f8a4e000    ....    STRH     lr,[r4,#0]
        0x10002af6:    f24b040c    K...    MOV      r4,#0xb00c
        0x10002afa:    f2c20400    ....    MOVT     r4,#0x2000
        0x10002afe:    6022        "`      STR      r2,[r4,#0]
        0x10002b00:    f24b0208    K...    MOV      r2,#0xb008
        0x10002b04:    f2c20200    ....    MOVT     r2,#0x2000
        0x10002b08:    6010        .`      STR      r0,[r2,#0]
        0x10002b0a:    f24b0014    K...    MOV      r0,#0xb014
        0x10002b0e:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002b12:    6001        .`      STR      r1,[r0,#0]
        0x10002b14:    f24b0018    K...    MOV      r0,#0xb018
        0x10002b18:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002b1c:    6003        .`      STR      r3,[r0,#0]
        0x10002b1e:    e8bd4010    ...@    POP      {r4,lr}
        0x10002b22:    f000b831    ..1.    B.W      app_debug_reinit ; 0x10002b88
        0x10002b26:    2010        .       MOVS     r0,#0x10
        0x10002b28:    bd10        ..      POP      {r4,pc}
        0x10002b2a:    0000        ..      MOVS     r0,r0
    app_debug_printf
        0x10002b2c:    b5f0        ..      PUSH     {r4-r7,lr}
        0x10002b2e:    b081        ..      SUB      sp,sp,#4
        0x10002b30:    f24b0404    K...    MOV      r4,#0xb004
        0x10002b34:    f2c20400    ....    MOVT     r4,#0x2000
        0x10002b38:    6820         h      LDR      r0,[r4,#0]
        0x10002b3a:    b318        ..      CBZ      r0,0x10002b84 ; app_debug_printf + 88
        0x10002b3c:    f24b0512    K...    MOV      r5,#0xb012
        0x10002b40:    f24b0610    K...    MOV      r6,#0xb010
        0x10002b44:    f2c20500    ....    MOVT     r5,#0x2000
        0x10002b48:    f2c20600    ....    MOVT     r6,#0x2000
        0x10002b4c:    8828        (.      LDRH     r0,[r5,#0]
        0x10002b4e:    8831        1.      LDRH     r1,[r6,#0]
        0x10002b50:    4288        .B      CMP      r0,r1
        0x10002b52:    d017        ..      BEQ      0x10002b84 ; app_debug_printf + 88
        0x10002b54:    f24b070c    K...    MOV      r7,#0xb00c
        0x10002b58:    f2c20700    ....    MOVT     r7,#0x2000
        0x10002b5c:    6821        !h      LDR      r1,[r4,#0]
        0x10002b5e:    b282        ..      UXTH     r2,r0
        0x10002b60:    6809        .h      LDR      r1,[r1,#0]
        0x10002b62:    6838        8h      LDR      r0,[r7,#0]
        0x10002b64:    5c89        .\      LDRB     r1,[r1,r2]
        0x10002b66:    f000f966    ..f.    BL       $Ven$TT$L$$rom_hw_uart_send_byte ; 0x10002e36
        0x10002b6a:    8828        (.      LDRH     r0,[r5,#0]
        0x10002b6c:    6821        !h      LDR      r1,[r4,#0]
        0x10002b6e:    3001        .0      ADDS     r0,#1
        0x10002b70:    b282        ..      UXTH     r2,r0
        0x10002b72:    8889        ..      LDRH     r1,[r1,#4]
        0x10002b74:    428a        .B      CMP      r2,r1
        0x10002b76:    bf28        (.      IT       CS
        0x10002b78:    2000        .       MOVCS    r0,#0
        0x10002b7a:    b281        ..      UXTH     r1,r0
        0x10002b7c:    8832        2.      LDRH     r2,[r6,#0]
        0x10002b7e:    8028        (.      STRH     r0,[r5,#0]
        0x10002b80:    4291        .B      CMP      r1,r2
        0x10002b82:    d1eb        ..      BNE      0x10002b5c ; app_debug_printf + 48
        0x10002b84:    b001        ..      ADD      sp,sp,#4
        0x10002b86:    bdf0        ..      POP      {r4-r7,pc}
    app_debug_reinit
        0x10002b88:    b5f0        ..      PUSH     {r4-r7,lr}
        0x10002b8a:    b083        ..      SUB      sp,sp,#0xc
        0x10002b8c:    f24b050c    K...    MOV      r5,#0xb00c
        0x10002b90:    f2c20500    ....    MOVT     r5,#0x2000
        0x10002b94:    6828        (h      LDR      r0,[r5,#0]
        0x10002b96:    f1b04fc0    ...O    CMP      r0,#0x60000000
        0x10002b9a:    d00a        ..      BEQ      0x10002bb2 ; app_debug_reinit + 42
        0x10002b9c:    f2404100    @..A    MOVW     r1,#0x400
        0x10002ba0:    f2c60100    ....    MOVT     r1,#0x6000
        0x10002ba4:    4288        .B      CMP      r0,r1
        0x10002ba6:    bf19        ..      ITTEE    NE
        0x10002ba8:    240c        .$      MOVNE    r4,#0xc
        0x10002baa:    202d        -       MOVNE    r0,#0x2d
        0x10002bac:    2408        .$      MOVEQ    r4,#8
        0x10002bae:    202c        ,       MOVEQ    r0,#0x2c
        0x10002bb0:    e001        ..      B        0x10002bb6 ; app_debug_reinit + 46
        0x10002bb2:    2404        .$      MOVS     r4,#4
        0x10002bb4:    202b        +       MOVS     r0,#0x2b
        0x10002bb6:    f000f907    ....    BL       $Ven$TT$L$$rom_hw_crg_enable_clk_gate ; 0x10002dc8
        0x10002bba:    f24b0608    K...    MOV      r6,#0xb008
        0x10002bbe:    f24b0714    K...    MOV      r7,#0xb014
        0x10002bc2:    f2c20600    ....    MOVT     r6,#0x2000
        0x10002bc6:    f2c20700    ....    MOVT     r7,#0x2000
        0x10002bca:    6830        0h      LDR      r0,[r6,#0]
        0x10002bcc:    6839        9h      LDR      r1,[r7,#0]
        0x10002bce:    4622        "F      MOV      r2,r4
        0x10002bd0:    f000f8e1    ....    BL       $Ven$TT$L$$rom_hw_gpio_set_pin_pid ; 0x10002d96
        0x10002bd4:    b108        ..      CBZ      r0,0x10002bda ; app_debug_reinit + 82
        0x10002bd6:    b003        ..      ADD      sp,sp,#0xc
        0x10002bd8:    bdf0        ..      POP      {r4-r7,pc}
        0x10002bda:    6830        0h      LDR      r0,[r6,#0]
        0x10002bdc:    6839        9h      LDR      r1,[r7,#0]
        0x10002bde:    2202        ."      MOVS     r2,#2
        0x10002be0:    f000f92e    ....    BL       $Ven$TT$L$$rom_hw_gpio_set_pin_pull_mode ; 0x10002e40
        0x10002be4:    2800        .(      CMP      r0,#0
        0x10002be6:    d1f6        ..      BNE      0x10002bd6 ; app_debug_reinit + 78
        0x10002be8:    f24b0018    K...    MOV      r0,#0xb018
        0x10002bec:    f2c20000    ....    MOVT     r0,#0x2000
        0x10002bf0:    6800        .h      LDR      r0,[r0,#0]
        0x10002bf2:    f2430121    C.!.    MOV      r1,#0x3021
        0x10002bf6:    9001        ..      STR      r0,[sp,#4]
        0x10002bf8:    f2c01101    ....    MOVT     r1,#0x101
        0x10002bfc:    6828        (h      LDR      r0,[r5,#0]
        0x10002bfe:    9102        ..      STR      r1,[sp,#8]
        0x10002c00:    a901        ..      ADD      r1,sp,#4
        0x10002c02:    f000f922    ..".    BL       $Ven$TT$L$$rom_hw_uart_init ; 0x10002e4a
        0x10002c06:    b003        ..      ADD      sp,sp,#0xc
        0x10002c08:    bdf0        ..      POP      {r4-r7,pc}
        0x10002c0a:    0000        ..      MOVS     r0,r0
    fputc
        0x10002c0c:    b510        ..      PUSH     {r4,lr}
        0x10002c0e:    b082        ..      SUB      sp,sp,#8
        0x10002c10:    f24b0104    K...    MOV      r1,#0xb004
        0x10002c14:    f2c20100    ....    MOVT     r1,#0x2000
        0x10002c18:    6809        .h      LDR      r1,[r1,#0]
        0x10002c1a:    b179        y.      CBZ      r1,0x10002c3c ; fputc + 48
        0x10002c1c:    f24b0310    K...    MOV      r3,#0xb010
        0x10002c20:    f2c20300    ....    MOVT     r3,#0x2000
        0x10002c24:    680a        .h      LDR      r2,[r1,#0]
        0x10002c26:    881c        ..      LDRH     r4,[r3,#0]
        0x10002c28:    5510        .U      STRB     r0,[r2,r4]
        0x10002c2a:    1c62        b.      ADDS     r2,r4,#1
        0x10002c2c:    b294        ..      UXTH     r4,r2
        0x10002c2e:    8889        ..      LDRH     r1,[r1,#4]
        0x10002c30:    428c        .B      CMP      r4,r1
        0x10002c32:    bf28        (.      IT       CS
        0x10002c34:    2200        ."      MOVCS    r2,#0
        0x10002c36:    801a        ..      STRH     r2,[r3,#0]
        0x10002c38:    b002        ..      ADD      sp,sp,#8
        0x10002c3a:    bd10        ..      POP      {r4,pc}
        0x10002c3c:    f24b010c    K...    MOV      r1,#0xb00c
        0x10002c40:    f2c20100    ....    MOVT     r1,#0x2000
        0x10002c44:    680a        .h      LDR      r2,[r1,#0]
        0x10002c46:    f88d0007    ....    STRB     r0,[sp,#7]
        0x10002c4a:    f10d0107    ....    ADD      r1,sp,#7
        0x10002c4e:    4604        .F      MOV      r4,r0
        0x10002c50:    4610        .F      MOV      r0,r2
        0x10002c52:    2201        ."      MOVS     r2,#1
        0x10002c54:    f000f8fe    ....    BL       $Ven$TT$L$$rom_hw_uart_transmit ; 0x10002e54
        0x10002c58:    4620         F      MOV      r0,r4
        0x10002c5a:    b002        ..      ADD      sp,sp,#8
        0x10002c5c:    bd10        ..      POP      {r4,pc}
        0x10002c5e:    0000        ..      MOVS     r0,r0
    main
        0x10002c60:    b084        ..      SUB      sp,sp,#0x10
        0x10002c62:    f24b0400    K...    MOVW     r4,#0xb000
        0x10002c66:    f2c60404    ....    MOVT     r4,#0x6004
        0x10002c6a:    2500        .%      MOVS     r5,#0
        0x10002c6c:    f5045040    ..@P    ADD      r0,r4,#0x3000
        0x10002c70:    9502        ..      STR      r5,[sp,#8]
        0x10002c72:    f000f8f4    ....    BL       $Ven$TT$L$$rom_hw_wdt_disable ; 0x10002e5e
        0x10002c76:    f44f707a    O.zp    MOV      r0,#0x3e8
        0x10002c7a:    f000f8a0    ....    BL       $Ven$TT$L$$rom_delay_ms ; 0x10002dbe
        0x10002c7e:    2002        .       MOVS     r0,#2
        0x10002c80:    f000f8f2    ....    BL       $Ven$TT$L$$rom_hw_pmu_set_ldo_act_voltage ; 0x10002e68
        0x10002c84:    2000        .       MOVS     r0,#0
        0x10002c86:    f000f8f4    ....    BL       $Ven$TT$L$$rom_hw_pmu_set_ldo_dig_voltage ; 0x10002e72
        0x10002c8a:    2000        .       MOVS     r0,#0
        0x10002c8c:    f000f8f6    ....    BL       $Ven$TT$L$$rom_hw_pmu_set_ldo_ret_sleep_voltage ; 0x10002e7c
        0x10002c90:    2000        .       MOVS     r0,#0
        0x10002c92:    f000f8f8    ....    BL       $Ven$TT$L$$rom_hal_pmu_sel_power_act_out_mode ; 0x10002e86
        0x10002c96:    f10d010f    ....    ADD      r1,sp,#0xf
        0x10002c9a:    200f        .       MOVS     r0,#0xf
        0x10002c9c:    2201        ."      MOVS     r2,#1
        0x10002c9e:    f88d500f    ...P    STRB     r5,[sp,#0xf]
        0x10002ca2:    f000f8f5    ....    BL       $Ven$TT$L$$rom_hw_efuse_read_bytes ; 0x10002e90
        0x10002ca6:    f89d000f    ....    LDRB     r0,[sp,#0xf]
        0x10002caa:    2800        .(      CMP      r0,#0
        0x10002cac:    bf04        ..      ITT      EQ
        0x10002cae:    2056        V       MOVEQ    r0,#0x56
        0x10002cb0:    f000f8f3    ....    BLEQ     $Ven$TT$L$$rom_hw_pmu_set_rc_hclk_tune ; 0x10002e9a
        0x10002cb4:    f10d010f    ....    ADD      r1,sp,#0xf
        0x10002cb8:    2010        .       MOVS     r0,#0x10
        0x10002cba:    2201        ."      MOVS     r2,#1
        0x10002cbc:    f000f8e8    ....    BL       $Ven$TT$L$$rom_hw_efuse_read_bytes ; 0x10002e90
        0x10002cc0:    f89d000f    ....    LDRB     r0,[sp,#0xf]
        0x10002cc4:    2800        .(      CMP      r0,#0
        0x10002cc6:    bf08        ..      IT       EQ
        0x10002cc8:    20a9        .       MOVEQ    r0,#0xa9
        0x10002cca:    f000f8eb    ....    BL       $Ven$TT$L$$rom_hw_pmu_set_rc_lclk_tune ; 0x10002ea4
        0x10002cce:    2000        .       MOVS     r0,#0
        0x10002cd0:    f000f8ed    ....    BL       $Ven$TT$L$$rom_hw_pmu_sel_dcxo_hclk_pwr ; 0x10002eae
        0x10002cd4:    2003        .       MOVS     r0,#3
        0x10002cd6:    2103        .!      MOVS     r1,#3
        0x10002cd8:    2264        d"      MOVS     r2,#0x64
        0x10002cda:    f000f8ed    ....    BL       $Ven$TT$L$$rom_hal_pmu_cfg_dcxo_hclk_param ; 0x10002eb8
        0x10002cde:    2001        .       MOVS     r0,#1
        0x10002ce0:    f64011c4    @...    MOV      r1,#0x9c4
        0x10002ce4:    f000f8ed    ....    BL       $Ven$TT$L$$rom_hal_pmu_set_sys_clk_src ; 0x10002ec2
        0x10002ce8:    2001        .       MOVS     r0,#1
        0x10002cea:    2100        .!      MOVS     r1,#0
        0x10002cec:    2200        ."      MOVS     r2,#0
        0x10002cee:    f000f8ed    ....    BL       $Ven$TT$L$$rom_hw_sys_ctrl_peri_int_ctrl ; 0x10002ecc
        0x10002cf2:    4620         F      MOV      r0,r4
        0x10002cf4:    f04f5100    O..Q    MOV      r1,#0x20000000
        0x10002cf8:    f04f42c0    O..B    MOV      r2,#0x60000000
        0x10002cfc:    f44f2361    O.a#    MOV      r3,#0xe1000
        0x10002d00:    9500        ..      STR      r5,[sp,#0]
        0x10002d02:    f7fffec7    ....    BL       app_debug_init ; 0x10002a94
        0x10002d06:    f7fffde9    ....    BL       SPH0645LM4H_Init ; 0x100028dc
        0x10002d0a:    f7fffd0d    ....    BL       I2S_MasterRx_Init ; 0x10002728
        0x10002d0e:    ac02        ..      ADD      r4,sp,#8
        0x10002d10:    4620         F      MOV      r0,r4
        0x10002d12:    f7fffce7    ....    BL       I2S_AcquireReadyBuffer ; 0x100026e4
        0x10002d16:    2800        .(      CMP      r0,#0
        0x10002d18:    d0fa        ..      BEQ      0x10002d10 ; main + 176
        0x10002d1a:    9d02        ..      LDR      r5,[sp,#8]
        0x10002d1c:    f7fffd00    ....    BL       I2S_GetRxSampleCount ; 0x10002720
        0x10002d20:    4601        .F      MOV      r1,r0
        0x10002d22:    4628        (F      MOV      r0,r5
        0x10002d24:    f7fffdf6    ....    BL       SPH0645LM4H_ProcessBuffer ; 0x10002914
        0x10002d28:    e7f2        ..      B        0x10002d10 ; main + 176
        0x10002d2a:    0000        ..      MOVS     r0,r0
    $t.1
    rom_hw_i2s_clear_interrupt_flag
        0x10002d2c:    2100        .!      MOVS     r1,#0
        0x10002d2e:    ebb12f90    .../    CMP      r1,r0,LSR #10
        0x10002d32:    bf1c        ..      ITT      NE
        0x10002d34:    2010        .       MOVNE    r0,#0x10
        0x10002d36:    4770        pG      BXNE     lr
        0x10002d38:    f24d0110    M...    MOV      r1,#0xd010
        0x10002d3c:    f36f209f    o..     BFC      r0,#10,#22
        0x10002d40:    f2c60102    ....    MOVT     r1,#0x6002
        0x10002d44:    6008        .`      STR      r0,[r1,#0]
        0x10002d46:    2000        .       MOVS     r0,#0
        0x10002d48:    4770        pG      BX       lr
        0x10002d4a:    0000        ..      MOVS     r0,r0
    rom_hw_i2s_deinit
        0x10002d4c:    f24d0110    M...    MOV      r1,#0xd010
        0x10002d50:    f2c60102    ....    MOVT     r1,#0x6002
        0x10002d54:    2000        .       MOVS     r0,#0
        0x10002d56:    6048        H`      STR      r0,[r1,#4]
        0x10002d58:    f24030ff    @..0    MOV      r0,#0x3ff
        0x10002d5c:    6008        .`      STR      r0,[r1,#0]
        0x10002d5e:    2020                MOVS     r0,#0x20
        0x10002d60:    60c8        .`      STR      r0,[r1,#0xc]
        0x10002d62:    f6410235    A.5.    MOV      r2,#0x1835
        0x10002d66:    2000        .       MOVS     r0,#0
        0x10002d68:    608a        .`      STR      r2,[r1,#8]
        0x10002d6a:    4770        pG      BX       lr
    rom_hw_i2s_init
        0x10002d6c:    4601        .F      MOV      r1,r0
        0x10002d6e:    f24d0218    M...    MOV      r2,#0xd018
        0x10002d72:    f36f41df    o..A    BFC      r1,#19,#13
        0x10002d76:    f2c60202    ....    MOVT     r2,#0x6002
        0x10002d7a:    2000        .       MOVS     r0,#0
        0x10002d7c:    6011        .`      STR      r1,[r2,#0]
        0x10002d7e:    4770        pG      BX       lr
    rom_hw_i2s_set_wclk_freq
        0x10002d80:    f24d011c    M...    MOV      r1,#0xd01c
        0x10002d84:    f2c60102    ....    MOVT     r1,#0x6002
        0x10002d88:    680a        .h      LDR      r2,[r1,#0]
        0x10002d8a:    f02202ff    "...    BIC      r2,r2,#0xff
        0x10002d8e:    4402        .D      ADD      r2,r2,r0
        0x10002d90:    2000        .       MOVS     r0,#0
        0x10002d92:    600a        .`      STR      r2,[r1,#0]
        0x10002d94:    4770        pG      BX       lr
    $t
    $Ven$TT$L$$rom_hw_gpio_set_pin_pid
        0x10002d96:    f6490c21    I.!.    MOV      r12,#0x9821
        0x10002d9a:    f2c00c00    ....    MOVT     r12,#0
        0x10002d9e:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_gpio_set_pin_input_output
        0x10002da0:    f2496cf1    I..l    MOV      r12,#0x96f1
        0x10002da4:    f2c00c00    ....    MOVT     r12,#0
        0x10002da8:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_gpio_set_pin_drive_strength
        0x10002daa:    f2496c71    I.ql    MOV      r12,#0x9671
        0x10002dae:    f2c00c00    ....    MOVT     r12,#0
        0x10002db2:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_gpio_set_pin_output_level
        0x10002db4:    f2497cf9    I..|    MOV      r12,#0x97f9
        0x10002db8:    f2c00c00    ....    MOVT     r12,#0
        0x10002dbc:    4760        `G      BX       r12
    $Ven$TT$L$$rom_delay_ms
        0x10002dbe:    f2447c71    D.q|    MOV      r12,#0x4771
        0x10002dc2:    f2c00c00    ....    MOVT     r12,#0
        0x10002dc6:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_crg_enable_clk_gate
        0x10002dc8:    f6471c7d    G.}.    MOV      r12,#0x797d
        0x10002dcc:    f2c00c00    ....    MOVT     r12,#0
        0x10002dd0:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_crg_keep_reset
        0x10002dd2:    f6472c85    G..,    MOV      r12,#0x7a85
        0x10002dd6:    f2c00c00    ....    MOVT     r12,#0
        0x10002dda:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_crg_release_reset
        0x10002ddc:    f6472cd1    G..,    MOV      r12,#0x7ad1
        0x10002de0:    f2c00c00    ....    MOVT     r12,#0
        0x10002de4:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_crg_set_i2s_bclk_divisor
        0x10002de6:    f6475c15    G..\    MOV      r12,#0x7d15
        0x10002dea:    f2c00c00    ....    MOVT     r12,#0
        0x10002dee:    4760        `G      BX       r12
    $Ven$TT$L$$rom_delay_us
        0x10002df0:    f2447c81    D..|    MOV      r12,#0x4781
        0x10002df4:    f2c00c00    ....    MOVT     r12,#0
        0x10002df8:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_sys_ctrl_enable_peri_int
        0x10002dfa:    f24c1cc5    L...    MOV      r12,#0xc1c5
        0x10002dfe:    f2c00c00    ....    MOVT     r12,#0
        0x10002e02:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_dma_disable
        0x10002e04:    f2480cad    H...    MOV      r12,#0x80ad
        0x10002e08:    f2c00c00    ....    MOVT     r12,#0
        0x10002e0c:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_dma_init
        0x10002e0e:    f2483c65    H.e<    MOV      r12,#0x8365
        0x10002e12:    f2c00c00    ....    MOVT     r12,#0
        0x10002e16:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_dma_set_interrupt_channel
        0x10002e18:    f2484cf1    H..L    MOV      r12,#0x84f1
        0x10002e1c:    f2c00c00    ....    MOVT     r12,#0
        0x10002e20:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_dma_enable_interrupt
        0x10002e22:    f2481c35    H.5.    MOV      r12,#0x8135
        0x10002e26:    f2c00c00    ....    MOVT     r12,#0
        0x10002e2a:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_dma_enable
        0x10002e2c:    f2481c15    H...    MOV      r12,#0x8115
        0x10002e30:    f2c00c00    ....    MOVT     r12,#0
        0x10002e34:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_uart_send_byte
        0x10002e36:    f64d7c7d    M.}|    MOV      r12,#0xdf7d
        0x10002e3a:    f2c00c00    ....    MOVT     r12,#0
        0x10002e3e:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_gpio_set_pin_pull_mode
        0x10002e40:    f6490c9d    I...    MOV      r12,#0x989d
        0x10002e44:    f2c00c00    ....    MOVT     r12,#0
        0x10002e48:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_uart_init
        0x10002e4a:    f64d6c65    M.el    MOV      r12,#0xde65
        0x10002e4e:    f2c00c00    ....    MOVT     r12,#0
        0x10002e52:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_uart_transmit
        0x10002e54:    f24e1ccd    N...    MOV      r12,#0xe1cd
        0x10002e58:    f2c00c00    ....    MOVT     r12,#0
        0x10002e5c:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_wdt_disable
        0x10002e5e:    f64f0c31    O.1.    MOV      r12,#0xf831
        0x10002e62:    f2c00c00    ....    MOVT     r12,#0
        0x10002e66:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_pmu_set_ldo_act_voltage
        0x10002e68:    f64a5c7d    J.}\    MOV      r12,#0xad7d
        0x10002e6c:    f2c00c00    ....    MOVT     r12,#0
        0x10002e70:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_pmu_set_ldo_dig_voltage
        0x10002e72:    f64a5ca9    J..\    MOV      r12,#0xada9
        0x10002e76:    f2c00c00    ....    MOVT     r12,#0
        0x10002e7a:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_pmu_set_ldo_ret_sleep_voltage
        0x10002e7c:    f64a5cfd    J..\    MOV      r12,#0xadfd
        0x10002e80:    f2c00c00    ....    MOVT     r12,#0
        0x10002e84:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hal_pmu_sel_power_act_out_mode
        0x10002e86:    f6454c21    E.!L    MOV      r12,#0x5c21
        0x10002e8a:    f2c00c00    ....    MOVT     r12,#0
        0x10002e8e:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_efuse_read_bytes
        0x10002e90:    f2487c0d    H..|    MOV      r12,#0x870d
        0x10002e94:    f2c00c00    ....    MOVT     r12,#0
        0x10002e98:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_pmu_set_rc_hclk_tune
        0x10002e9a:    f64a6c59    J.Yl    MOV      r12,#0xae59
        0x10002e9e:    f2c00c00    ....    MOVT     r12,#0
        0x10002ea2:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_pmu_set_rc_lclk_tune
        0x10002ea4:    f64a6c69    J.il    MOV      r12,#0xae69
        0x10002ea8:    f2c00c00    ....    MOVT     r12,#0
        0x10002eac:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_pmu_sel_dcxo_hclk_pwr
        0x10002eae:    f64a3cb1    J..<    MOV      r12,#0xabb1
        0x10002eb2:    f2c00c00    ....    MOVT     r12,#0
        0x10002eb6:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hal_pmu_cfg_dcxo_hclk_param
        0x10002eb8:    f6451c65    E.e.    MOV      r12,#0x5965
        0x10002ebc:    f2c00c00    ....    MOVT     r12,#0
        0x10002ec0:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hal_pmu_set_sys_clk_src
        0x10002ec2:    f6455c29    E.)\    MOV      r12,#0x5d29
        0x10002ec6:    f2c00c00    ....    MOVT     r12,#0
        0x10002eca:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_sys_ctrl_peri_int_ctrl
        0x10002ecc:    f24c3c11    L..<    MOV      r12,#0xc311
        0x10002ed0:    f2c00c00    ....    MOVT     r12,#0
        0x10002ed4:    4760        `G      BX       r12
        0x10002ed6:    0000        ..      MOVS     r0,r0
    i.__0printf$8
    __0printf$8
    __1printf$8
    __2printf
        0x10002ed8:    b40f        ..      PUSH     {r0-r3}
        0x10002eda:    4b05        .K      LDR      r3,[pc,#20] ; [0x10002ef0] = 0x10002c0d
        0x10002edc:    b510        ..      PUSH     {r4,lr}
        0x10002ede:    a903        ..      ADD      r1,sp,#0xc
        0x10002ee0:    4a04        .J      LDR      r2,[pc,#16] ; [0x10002ef4] = 0x2000b000
        0x10002ee2:    9802        ..      LDR      r0,[sp,#8]
        0x10002ee4:    f000f808    ....    BL       _printf_core ; 0x10002ef8
        0x10002ee8:    bc10        ..      POP      {r4}
        0x10002eea:    f85dfb14    ]...    LDR      pc,[sp],#0x14
    $d
        0x10002eee:    0000        ..      DCW    0
        0x10002ef0:    10002c0d    .,..    DCD    268446733
        0x10002ef4:    2000b000    ...     DCD    536915968
    $t
    i._printf_core
    _printf_core
        0x10002ef8:    e92d4fff    -..O    PUSH     {r0-r11,lr}
        0x10002efc:    b08d        ..      SUB      sp,sp,#0x34
        0x10002efe:    460f        .F      MOV      r7,r1
        0x10002f00:    4605        .F      MOV      r5,r0
        0x10002f02:    2600        .&      MOVS     r6,#0
        0x10002f04:    e006        ..      B        0x10002f14 ; _printf_core + 28
        0x10002f06:    2825        %(      CMP      r0,#0x25
        0x10002f08:    d00b        ..      BEQ      0x10002f22 ; _printf_core + 42
        0x10002f0a:    e9dd120f    ....    LDRD     r1,r2,[sp,#0x3c]
        0x10002f0e:    4790        .G      BLX      r2
        0x10002f10:    1c6d        m.      ADDS     r5,r5,#1
        0x10002f12:    1c76        v.      ADDS     r6,r6,#1
        0x10002f14:    7828        (x      LDRB     r0,[r5,#0]
        0x10002f16:    2800        .(      CMP      r0,#0
        0x10002f18:    d1f5        ..      BNE      0x10002f06 ; _printf_core + 14
        0x10002f1a:    b011        ..      ADD      sp,sp,#0x44
        0x10002f1c:    4630        0F      MOV      r0,r6
        0x10002f1e:    e8bd8ff0    ....    POP      {r4-r11,pc}
        0x10002f22:    2400        .$      MOVS     r4,#0
        0x10002f24:    46a2        .F      MOV      r10,r4
        0x10002f26:    46a1        .F      MOV      r9,r4
        0x10002f28:    2201        ."      MOVS     r2,#1
        0x10002f2a:    49ec        .I      LDR      r1,[pc,#944] ; [0x100032dc] = 0x12809
        0x10002f2c:    e000        ..      B        0x10002f30 ; _printf_core + 56
        0x10002f2e:    4304        .C      ORRS     r4,r4,r0
        0x10002f30:    f8153f01    ...?    LDRB     r3,[r5,#1]!
        0x10002f34:    3b20         ;      SUBS     r3,r3,#0x20
        0x10002f36:    fa02f003    ....    LSL      r0,r2,r3
        0x10002f3a:    4208        .B      TST      r0,r1
        0x10002f3c:    d1f7        ..      BNE      0x10002f2e ; _printf_core + 54
        0x10002f3e:    7828        (x      LDRB     r0,[r5,#0]
        0x10002f40:    282a        *(      CMP      r0,#0x2a
        0x10002f42:    d010        ..      BEQ      0x10002f66 ; _printf_core + 110
        0x10002f44:    f06f022f    o./.    MVN      r2,#0x2f
        0x10002f48:    7828        (x      LDRB     r0,[r5,#0]
        0x10002f4a:    f1a00130    ..0.    SUB      r1,r0,#0x30
        0x10002f4e:    2909        .)      CMP      r1,#9
        0x10002f50:    d814        ..      BHI      0x10002f7c ; _printf_core + 132
        0x10002f52:    eb0a018a    ....    ADD      r1,r10,r10,LSL #2
        0x10002f56:    eb020141    ..A.    ADD      r1,r2,r1,LSL #1
        0x10002f5a:    f0440402    D...    ORR      r4,r4,#2
        0x10002f5e:    eb000a01    ....    ADD      r10,r0,r1
        0x10002f62:    1c6d        m.      ADDS     r5,r5,#1
        0x10002f64:    e7f0        ..      B        0x10002f48 ; _printf_core + 80
        0x10002f66:    cf01        ..      LDM      r7!,{r0}
        0x10002f68:    ea5f0a00    _...    MOVS     r10,r0
        0x10002f6c:    d503        ..      BPL      0x10002f76 ; _printf_core + 126
        0x10002f6e:    f4445400    D..T    ORR      r4,r4,#0x2000
        0x10002f72:    f1ca0a00    ....    RSB      r10,r10,#0
        0x10002f76:    f0440402    D...    ORR      r4,r4,#2
        0x10002f7a:    1c6d        m.      ADDS     r5,r5,#1
        0x10002f7c:    7828        (x      LDRB     r0,[r5,#0]
        0x10002f7e:    282e        .(      CMP      r0,#0x2e
        0x10002f80:    d117        ..      BNE      0x10002fb2 ; _printf_core + 186
        0x10002f82:    f8150f01    ....    LDRB     r0,[r5,#1]!
        0x10002f86:    f0440404    D...    ORR      r4,r4,#4
        0x10002f8a:    282a        *(      CMP      r0,#0x2a
        0x10002f8c:    d00e        ..      BEQ      0x10002fac ; _printf_core + 180
        0x10002f8e:    f06f022f    o./.    MVN      r2,#0x2f
        0x10002f92:    7828        (x      LDRB     r0,[r5,#0]
        0x10002f94:    f1a00130    ..0.    SUB      r1,r0,#0x30
        0x10002f98:    2909        .)      CMP      r1,#9
        0x10002f9a:    d80a        ..      BHI      0x10002fb2 ; _printf_core + 186
        0x10002f9c:    eb090189    ....    ADD      r1,r9,r9,LSL #2
        0x10002fa0:    eb020141    ..A.    ADD      r1,r2,r1,LSL #1
        0x10002fa4:    eb000901    ....    ADD      r9,r0,r1
        0x10002fa8:    1c6d        m.      ADDS     r5,r5,#1
        0x10002faa:    e7f2        ..      B        0x10002f92 ; _printf_core + 154
        0x10002fac:    f8579b04    W...    LDR      r9,[r7],#4
        0x10002fb0:    1c6d        m.      ADDS     r5,r5,#1
        0x10002fb2:    7828        (x      LDRB     r0,[r5,#0]
        0x10002fb4:    286c        l(      CMP      r0,#0x6c
        0x10002fb6:    d00f        ..      BEQ      0x10002fd8 ; _printf_core + 224
        0x10002fb8:    dc06        ..      BGT      0x10002fc8 ; _printf_core + 208
        0x10002fba:    284c        L(      CMP      r0,#0x4c
        0x10002fbc:    d017        ..      BEQ      0x10002fee ; _printf_core + 246
        0x10002fbe:    2868        h(      CMP      r0,#0x68
        0x10002fc0:    d00d        ..      BEQ      0x10002fde ; _printf_core + 230
        0x10002fc2:    286a        j(      CMP      r0,#0x6a
        0x10002fc4:    d114        ..      BNE      0x10002ff0 ; _printf_core + 248
        0x10002fc6:    e004        ..      B        0x10002fd2 ; _printf_core + 218
        0x10002fc8:    2874        t(      CMP      r0,#0x74
        0x10002fca:    d010        ..      BEQ      0x10002fee ; _printf_core + 246
        0x10002fcc:    287a        z(      CMP      r0,#0x7a
        0x10002fce:    d10f        ..      BNE      0x10002ff0 ; _printf_core + 248
        0x10002fd0:    e00d        ..      B        0x10002fee ; _printf_core + 246
        0x10002fd2:    f4441400    D...    ORR      r4,r4,#0x200000
        0x10002fd6:    e00a        ..      B        0x10002fee ; _printf_core + 246
        0x10002fd8:    f4441480    D...    ORR      r4,r4,#0x100000
        0x10002fdc:    e001        ..      B        0x10002fe2 ; _printf_core + 234
        0x10002fde:    f4441440    D.@.    ORR      r4,r4,#0x300000
        0x10002fe2:    7869        ix      LDRB     r1,[r5,#1]
        0x10002fe4:    4281        .B      CMP      r1,r0
        0x10002fe6:    d102        ..      BNE      0x10002fee ; _printf_core + 246
        0x10002fe8:    f5041480    ....    ADD      r4,r4,#0x100000
        0x10002fec:    1c6d        m.      ADDS     r5,r5,#1
        0x10002fee:    1c6d        m.      ADDS     r5,r5,#1
        0x10002ff0:    782a        *x      LDRB     r2,[r5,#0]
        0x10002ff2:    2a6e        n*      CMP      r2,#0x6e
        0x10002ff4:    d01f        ..      BEQ      0x10003036 ; _printf_core + 318
        0x10002ff6:    dc0c        ..      BGT      0x10003012 ; _printf_core + 282
        0x10002ff8:    2a63        c*      CMP      r2,#0x63
        0x10002ffa:    d031        1.      BEQ      0x10003060 ; _printf_core + 360
        0x10002ffc:    dc04        ..      BGT      0x10003008 ; _printf_core + 272
        0x10002ffe:    2a00        .*      CMP      r2,#0
        0x10003000:    d08b        ..      BEQ      0x10002f1a ; _printf_core + 34
        0x10003002:    2a58        X*      CMP      r2,#0x58
        0x10003004:    d111        ..      BNE      0x1000302a ; _printf_core + 306
        0x10003006:    e0a3        ..      B        0x10003150 ; _printf_core + 600
        0x10003008:    2a64        d*      CMP      r2,#0x64
        0x1000300a:    d068        h.      BEQ      0x100030de ; _printf_core + 486
        0x1000300c:    2a69        i*      CMP      r2,#0x69
        0x1000300e:    d10c        ..      BNE      0x1000302a ; _printf_core + 306
        0x10003010:    e065        e.      B        0x100030de ; _printf_core + 486
        0x10003012:    2a73        s*      CMP      r2,#0x73
        0x10003014:    d02e        ..      BEQ      0x10003074 ; _printf_core + 380
        0x10003016:    dc04        ..      BGT      0x10003022 ; _printf_core + 298
        0x10003018:    2a6f        o*      CMP      r2,#0x6f
        0x1000301a:    d073        s.      BEQ      0x10003104 ; _printf_core + 524
        0x1000301c:    2a70        p*      CMP      r2,#0x70
        0x1000301e:    d104        ..      BNE      0x1000302a ; _printf_core + 306
        0x10003020:    e09b        ..      B        0x1000315a ; _printf_core + 610
        0x10003022:    2a75        u*      CMP      r2,#0x75
        0x10003024:    d06f        o.      BEQ      0x10003106 ; _printf_core + 526
        0x10003026:    2a78        x*      CMP      r2,#0x78
        0x10003028:    d06e        n.      BEQ      0x10003108 ; _printf_core + 528
        0x1000302a:    4610        .F      MOV      r0,r2
        0x1000302c:    e9dd120f    ....    LDRD     r1,r2,[sp,#0x3c]
        0x10003030:    4790        .G      BLX      r2
        0x10003032:    1c76        v.      ADDS     r6,r6,#1
        0x10003034:    e150        P.      B        0x100032d8 ; _printf_core + 992
        0x10003036:    f3c45002    ...P    UBFX     r0,r4,#20,#3
        0x1000303a:    2802        .(      CMP      r0,#2
        0x1000303c:    d006        ..      BEQ      0x1000304c ; _printf_core + 340
        0x1000303e:    2803        .(      CMP      r0,#3
        0x10003040:    d009        ..      BEQ      0x10003056 ; _printf_core + 350
        0x10003042:    2804        .(      CMP      r0,#4
        0x10003044:    cf01        ..      LDM      r7!,{r0}
        0x10003046:    d009        ..      BEQ      0x1000305c ; _printf_core + 356
        0x10003048:    6006        .`      STR      r6,[r0,#0]
        0x1000304a:    e145        E.      B        0x100032d8 ; _printf_core + 992
        0x1000304c:    cf01        ..      LDM      r7!,{r0}
        0x1000304e:    17f1        ..      ASRS     r1,r6,#31
        0x10003050:    e9c06100    ...a    STRD     r6,r1,[r0,#0]
        0x10003054:    e140        @.      B        0x100032d8 ; _printf_core + 992
        0x10003056:    cf01        ..      LDM      r7!,{r0}
        0x10003058:    8006        ..      STRH     r6,[r0,#0]
        0x1000305a:    e13d        =.      B        0x100032d8 ; _printf_core + 992
        0x1000305c:    7006        .p      STRB     r6,[r0,#0]
        0x1000305e:    e13b        ;.      B        0x100032d8 ; _printf_core + 992
        0x10003060:    f8170b04    ....    LDRB     r0,[r7],#4
        0x10003064:    f88d0000    ....    STRB     r0,[sp,#0]
        0x10003068:    2000        .       MOVS     r0,#0
        0x1000306a:    f88d0001    ....    STRB     r0,[sp,#1]
        0x1000306e:    46eb        .F      MOV      r11,sp
        0x10003070:    2001        .       MOVS     r0,#1
        0x10003072:    e003        ..      B        0x1000307c ; _printf_core + 388
        0x10003074:    f857bb04    W...    LDR      r11,[r7],#4
        0x10003078:    f04f30ff    O..0    MOV      r0,#0xffffffff
        0x1000307c:    0761        a.      LSLS     r1,r4,#29
        0x1000307e:    f04f0100    O...    MOV      r1,#0
        0x10003082:    d402        ..      BMI      0x1000308a ; _printf_core + 402
        0x10003084:    e00d        ..      B        0x100030a2 ; _printf_core + 426
        0x10003086:    f1080101    ....    ADD      r1,r8,#1
        0x1000308a:    4688        .F      MOV      r8,r1
        0x1000308c:    4549        IE      CMP      r1,r9
        0x1000308e:    da0f        ..      BGE      0x100030b0 ; _printf_core + 440
        0x10003090:    4580        .E      CMP      r8,r0
        0x10003092:    dbf8        ..      BLT      0x10003086 ; _printf_core + 398
        0x10003094:    f81b1008    ....    LDRB     r1,[r11,r8]
        0x10003098:    2900        .)      CMP      r1,#0
        0x1000309a:    d1f4        ..      BNE      0x10003086 ; _printf_core + 398
        0x1000309c:    e008        ..      B        0x100030b0 ; _printf_core + 440
        0x1000309e:    f1080101    ....    ADD      r1,r8,#1
        0x100030a2:    4688        .F      MOV      r8,r1
        0x100030a4:    4281        .B      CMP      r1,r0
        0x100030a6:    dbfa        ..      BLT      0x1000309e ; _printf_core + 422
        0x100030a8:    f81b1008    ....    LDRB     r1,[r11,r8]
        0x100030ac:    2900        .)      CMP      r1,#0
        0x100030ae:    d1f6        ..      BNE      0x1000309e ; _printf_core + 422
        0x100030b0:    e9dd230f    ...#    LDRD     r2,r3,[sp,#0x3c]
        0x100030b4:    ebaa0008    ....    SUB      r0,r10,r8
        0x100030b8:    4681        .F      MOV      r9,r0
        0x100030ba:    4621        !F      MOV      r1,r4
        0x100030bc:    f000f936    ..6.    BL       _printf_pre_padding ; 0x1000332c
        0x100030c0:    4430        0D      ADD      r0,r0,r6
        0x100030c2:    eb000608    ....    ADD      r6,r0,r8
        0x100030c6:    e004        ..      B        0x100030d2 ; _printf_core + 474
        0x100030c8:    e9dd120f    ....    LDRD     r1,r2,[sp,#0x3c]
        0x100030cc:    f81b0b01    ....    LDRB     r0,[r11],#1
        0x100030d0:    4790        .G      BLX      r2
        0x100030d2:    f1b80801    ....    SUBS     r8,r8,#1
        0x100030d6:    d2f7        ..      BCS      0x100030c8 ; _printf_core + 464
        0x100030d8:    4621        !F      MOV      r1,r4
        0x100030da:    4648        HF      MOV      r0,r9
        0x100030dc:    e0f7        ..      B        0x100032ce ; _printf_core + 982
        0x100030de:    210a        .!      MOVS     r1,#0xa
        0x100030e0:    f3c45302    ...S    UBFX     r3,r4,#20,#3
        0x100030e4:    f04f0b00    O...    MOV      r11,#0
        0x100030e8:    9108        ..      STR      r1,[sp,#0x20]
        0x100030ea:    2b02        .+      CMP      r3,#2
        0x100030ec:    d004        ..      BEQ      0x100030f8 ; _printf_core + 512
        0x100030ee:    cf01        ..      LDM      r7!,{r0}
        0x100030f0:    17c1        ..      ASRS     r1,r0,#31
        0x100030f2:    2b03        .+      CMP      r3,#3
        0x100030f4:    d009        ..      BEQ      0x1000310a ; _printf_core + 530
        0x100030f6:    e00a        ..      B        0x1000310e ; _printf_core + 534
        0x100030f8:    1dff        ..      ADDS     r7,r7,#7
        0x100030fa:    f0270707    '...    BIC      r7,r7,#7
        0x100030fe:    e8f70102    ....    LDRD     r0,r1,[r7],#8
        0x10003102:    e008        ..      B        0x10003116 ; _printf_core + 542
        0x10003104:    e032        2.      B        0x1000316c ; _printf_core + 628
        0x10003106:    e01f        ..      B        0x10003148 ; _printf_core + 592
        0x10003108:    e020         .      B        0x1000314c ; _printf_core + 596
        0x1000310a:    b200        ..      SXTH     r0,r0
        0x1000310c:    17c1        ..      ASRS     r1,r0,#31
        0x1000310e:    2b04        .+      CMP      r3,#4
        0x10003110:    d101        ..      BNE      0x10003116 ; _printf_core + 542
        0x10003112:    b240        @.      SXTB     r0,r0
        0x10003114:    17c1        ..      ASRS     r1,r0,#31
        0x10003116:    1e03        ..      SUBS     r3,r0,#0
        0x10003118:    f1710300    q...    SBCS     r3,r1,#0
        0x1000311c:    da07        ..      BGE      0x1000312e ; _printf_core + 566
        0x1000311e:    f04f0c00    O...    MOV      r12,#0
        0x10003122:    ebd0000c    ....    RSBS     r0,r0,r12
        0x10003126:    eb6c0101    l...    SBC      r1,r12,r1
        0x1000312a:    232d        -#      MOVS     r3,#0x2d
        0x1000312c:    e002        ..      B        0x10003134 ; _printf_core + 572
        0x1000312e:    0523        #.      LSLS     r3,r4,#20
        0x10003130:    d504        ..      BPL      0x1000313c ; _printf_core + 580
        0x10003132:    232b        +#      MOVS     r3,#0x2b
        0x10003134:    f88d3024    ..$0    STRB     r3,[sp,#0x24]
        0x10003138:    2301        .#      MOVS     r3,#1
        0x1000313a:    e003        ..      B        0x10003144 ; _printf_core + 588
        0x1000313c:    07e3        ..      LSLS     r3,r4,#31
        0x1000313e:    d001        ..      BEQ      0x10003144 ; _printf_core + 588
        0x10003140:    2320         #      MOVS     r3,#0x20
        0x10003142:    e7f7        ..      B        0x10003134 ; _printf_core + 572
        0x10003144:    4698        .F      MOV      r8,r3
        0x10003146:    e058        X.      B        0x100031fa ; _printf_core + 770
        0x10003148:    210a        .!      MOVS     r1,#0xa
        0x1000314a:    e010        ..      B        0x1000316e ; _printf_core + 630
        0x1000314c:    2110        .!      MOVS     r1,#0x10
        0x1000314e:    e00e        ..      B        0x1000316e ; _printf_core + 630
        0x10003150:    2010        .       MOVS     r0,#0x10
        0x10003152:    f04f0b00    O...    MOV      r11,#0
        0x10003156:    9008        ..      STR      r0,[sp,#0x20]
        0x10003158:    e00c        ..      B        0x10003174 ; _printf_core + 636
        0x1000315a:    2110        .!      MOVS     r1,#0x10
        0x1000315c:    f04f0b00    O...    MOV      r11,#0
        0x10003160:    f0440404    D...    ORR      r4,r4,#4
        0x10003164:    f04f0908    O...    MOV      r9,#8
        0x10003168:    9108        ..      STR      r1,[sp,#0x20]
        0x1000316a:    e003        ..      B        0x10003174 ; _printf_core + 636
        0x1000316c:    2108        .!      MOVS     r1,#8
        0x1000316e:    f04f0b00    O...    MOV      r11,#0
        0x10003172:    9108        ..      STR      r1,[sp,#0x20]
        0x10003174:    f3c45302    ...S    UBFX     r3,r4,#20,#3
        0x10003178:    2b02        .+      CMP      r3,#2
        0x1000317a:    d004        ..      BEQ      0x10003186 ; _printf_core + 654
        0x1000317c:    cf01        ..      LDM      r7!,{r0}
        0x1000317e:    2100        .!      MOVS     r1,#0
        0x10003180:    2b03        .+      CMP      r3,#3
        0x10003182:    d006        ..      BEQ      0x10003192 ; _printf_core + 666
        0x10003184:    e006        ..      B        0x10003194 ; _printf_core + 668
        0x10003186:    1dff        ..      ADDS     r7,r7,#7
        0x10003188:    f0270707    '...    BIC      r7,r7,#7
        0x1000318c:    e8f70102    ....    LDRD     r0,r1,[r7],#8
        0x10003190:    e003        ..      B        0x1000319a ; _printf_core + 674
        0x10003192:    b280        ..      UXTH     r0,r0
        0x10003194:    2b04        .+      CMP      r3,#4
        0x10003196:    d100        ..      BNE      0x1000319a ; _printf_core + 674
        0x10003198:    b2c0        ..      UXTB     r0,r0
        0x1000319a:    f04f0800    O...    MOV      r8,#0
        0x1000319e:    0723        #.      LSLS     r3,r4,#28
        0x100031a0:    d52b        +.      BPL      0x100031fa ; _printf_core + 770
        0x100031a2:    2a70        p*      CMP      r2,#0x70
        0x100031a4:    d007        ..      BEQ      0x100031b6 ; _printf_core + 702
        0x100031a6:    f8ddc020    .. .    LDR      r12,[sp,#0x20]
        0x100031aa:    f08c0c10    ....    EOR      r12,r12,#0x10
        0x100031ae:    ea5c0c0b    \...    ORRS     r12,r12,r11
        0x100031b2:    d005        ..      BEQ      0x100031c0 ; _printf_core + 712
        0x100031b4:    e00e        ..      B        0x100031d4 ; _printf_core + 732
        0x100031b6:    2340        @#      MOVS     r3,#0x40
        0x100031b8:    f88d3024    ..$0    STRB     r3,[sp,#0x24]
        0x100031bc:    2301        .#      MOVS     r3,#1
        0x100031be:    e008        ..      B        0x100031d2 ; _printf_core + 730
        0x100031c0:    ea500301    P...    ORRS     r3,r0,r1
        0x100031c4:    d006        ..      BEQ      0x100031d4 ; _printf_core + 732
        0x100031c6:    2330        0#      MOVS     r3,#0x30
        0x100031c8:    f88d3024    ..$0    STRB     r3,[sp,#0x24]
        0x100031cc:    f88d2025    ..%     STRB     r2,[sp,#0x25]
        0x100031d0:    2302        .#      MOVS     r3,#2
        0x100031d2:    4698        .F      MOV      r8,r3
        0x100031d4:    f8ddc020    .. .    LDR      r12,[sp,#0x20]
        0x100031d8:    f08c0c08    ....    EOR      r12,r12,#8
        0x100031dc:    ea5c0c0b    \...    ORRS     r12,r12,r11
        0x100031e0:    d10b        ..      BNE      0x100031fa ; _printf_core + 770
        0x100031e2:    ea500301    P...    ORRS     r3,r0,r1
        0x100031e6:    d101        ..      BNE      0x100031ec ; _printf_core + 756
        0x100031e8:    0763        c.      LSLS     r3,r4,#29
        0x100031ea:    d506        ..      BPL      0x100031fa ; _printf_core + 770
        0x100031ec:    2330        0#      MOVS     r3,#0x30
        0x100031ee:    f88d3024    ..$0    STRB     r3,[sp,#0x24]
        0x100031f2:    f04f0801    O...    MOV      r8,#1
        0x100031f6:    f1a90901    ....    SUB      r9,r9,#1
        0x100031fa:    2a58        X*      CMP      r2,#0x58
        0x100031fc:    d004        ..      BEQ      0x10003208 ; _printf_core + 784
        0x100031fe:    a238        8.      ADR      r2,{pc}+0xe2 ; 0x100032e0
        0x10003200:    920b        ..      STR      r2,[sp,#0x2c]
        0x10003202:    aa08        ..      ADD      r2,sp,#0x20
        0x10003204:    920a        ..      STR      r2,[sp,#0x28]
        0x10003206:    e00b        ..      B        0x10003220 ; _printf_core + 808
        0x10003208:    a23a        :.      ADR      r2,{pc}+0xec ; 0x100032f4
        0x1000320a:    e7f9        ..      B        0x10003200 ; _printf_core + 776
        0x1000320c:    465b        [F      MOV      r3,r11
        0x1000320e:    9a08        ..      LDR      r2,[sp,#0x20]
        0x10003210:    f7fff880    ....    BL       __aeabi_uldivmod ; 0x10002314
        0x10003214:    9b0b        ..      LDR      r3,[sp,#0x2c]
        0x10003216:    5c9b        .\      LDRB     r3,[r3,r2]
        0x10003218:    9a0a        ..      LDR      r2,[sp,#0x28]
        0x1000321a:    1e52        R.      SUBS     r2,r2,#1
        0x1000321c:    920a        ..      STR      r2,[sp,#0x28]
        0x1000321e:    7013        .p      STRB     r3,[r2,#0]
        0x10003220:    ea500201    P...    ORRS     r2,r0,r1
        0x10003224:    d1f2        ..      BNE      0x1000320c ; _printf_core + 788
        0x10003226:    980a        ..      LDR      r0,[sp,#0x28]
        0x10003228:    ebad0000    ....    SUB      r0,sp,r0
        0x1000322c:    f1000b20    .. .    ADD      r11,r0,#0x20
        0x10003230:    0760        `.      LSLS     r0,r4,#29
        0x10003232:    d502        ..      BPL      0x1000323a ; _printf_core + 834
        0x10003234:    f4243480    $..4    BIC      r4,r4,#0x10000
        0x10003238:    e001        ..      B        0x1000323e ; _printf_core + 838
        0x1000323a:    f04f0901    O...    MOV      r9,#1
        0x1000323e:    45d9        .E      CMP      r9,r11
        0x10003240:    dd02        ..      BLE      0x10003248 ; _printf_core + 848
        0x10003242:    eba9000b    ....    SUB      r0,r9,r11
        0x10003246:    e000        ..      B        0x1000324a ; _printf_core + 850
        0x10003248:    2000        .       MOVS     r0,#0
        0x1000324a:    eb00010b    ....    ADD      r1,r0,r11
        0x1000324e:    4441        AD      ADD      r1,r1,r8
        0x10003250:    9008        ..      STR      r0,[sp,#0x20]
        0x10003252:    ebaa0a01    ....    SUB      r10,r10,r1
        0x10003256:    03e0        ..      LSLS     r0,r4,#15
        0x10003258:    d406        ..      BMI      0x10003268 ; _printf_core + 880
        0x1000325a:    e9dd230f    ...#    LDRD     r2,r3,[sp,#0x3c]
        0x1000325e:    4621        !F      MOV      r1,r4
        0x10003260:    4650        PF      MOV      r0,r10
        0x10003262:    f000f863    ..c.    BL       _printf_pre_padding ; 0x1000332c
        0x10003266:    4406        .D      ADD      r6,r6,r0
        0x10003268:    f04f0900    O...    MOV      r9,#0
        0x1000326c:    e008        ..      B        0x10003280 ; _printf_core + 904
        0x1000326e:    a909        ..      ADD      r1,sp,#0x24
        0x10003270:    f8110009    ....    LDRB     r0,[r1,r9]
        0x10003274:    e9dd120f    ....    LDRD     r1,r2,[sp,#0x3c]
        0x10003278:    4790        .G      BLX      r2
        0x1000327a:    f1090901    ....    ADD      r9,r9,#1
        0x1000327e:    1c76        v.      ADDS     r6,r6,#1
        0x10003280:    45c1        .E      CMP      r9,r8
        0x10003282:    dbf4        ..      BLT      0x1000326e ; _printf_core + 886
        0x10003284:    03e0        ..      LSLS     r0,r4,#15
        0x10003286:    d50c        ..      BPL      0x100032a2 ; _printf_core + 938
        0x10003288:    e9dd230f    ...#    LDRD     r2,r3,[sp,#0x3c]
        0x1000328c:    4621        !F      MOV      r1,r4
        0x1000328e:    4650        PF      MOV      r0,r10
        0x10003290:    f000f84c    ..L.    BL       _printf_pre_padding ; 0x1000332c
        0x10003294:    4406        .D      ADD      r6,r6,r0
        0x10003296:    e004        ..      B        0x100032a2 ; _printf_core + 938
        0x10003298:    e9dd120f    ....    LDRD     r1,r2,[sp,#0x3c]
        0x1000329c:    2030        0       MOVS     r0,#0x30
        0x1000329e:    4790        .G      BLX      r2
        0x100032a0:    1c76        v.      ADDS     r6,r6,#1
        0x100032a2:    9908        ..      LDR      r1,[sp,#0x20]
        0x100032a4:    1e48        H.      SUBS     r0,r1,#1
        0x100032a6:    9008        ..      STR      r0,[sp,#0x20]
        0x100032a8:    2900        .)      CMP      r1,#0
        0x100032aa:    dcf5        ..      BGT      0x10003298 ; _printf_core + 928
        0x100032ac:    e008        ..      B        0x100032c0 ; _printf_core + 968
        0x100032ae:    980a        ..      LDR      r0,[sp,#0x28]
        0x100032b0:    990a        ..      LDR      r1,[sp,#0x28]
        0x100032b2:    7800        .x      LDRB     r0,[r0,#0]
        0x100032b4:    1c49        I.      ADDS     r1,r1,#1
        0x100032b6:    910a        ..      STR      r1,[sp,#0x28]
        0x100032b8:    e9dd120f    ....    LDRD     r1,r2,[sp,#0x3c]
        0x100032bc:    4790        .G      BLX      r2
        0x100032be:    1c76        v.      ADDS     r6,r6,#1
        0x100032c0:    f1bb0100    ....    SUBS     r1,r11,#0
        0x100032c4:    f1ab0b01    ....    SUB      r11,r11,#1
        0x100032c8:    dcf1        ..      BGT      0x100032ae ; _printf_core + 950
        0x100032ca:    4621        !F      MOV      r1,r4
        0x100032cc:    4650        PF      MOV      r0,r10
        0x100032ce:    e9dd230f    ...#    LDRD     r2,r3,[sp,#0x3c]
        0x100032d2:    f000f819    ....    BL       _printf_post_padding ; 0x10003308
        0x100032d6:    4406        .D      ADD      r6,r6,r0
        0x100032d8:    1c6d        m.      ADDS     r5,r5,#1
        0x100032da:    e61b        ..      B        0x10002f14 ; _printf_core + 28
    $d
        0x100032dc:    00012809    .(..    DCD    75785
        0x100032e0:    33323130    0123    DCD    858927408
        0x100032e4:    37363534    4567    DCD    926299444
        0x100032e8:    62613938    89ab    DCD    1650538808
        0x100032ec:    66656463    cdef    DCD    1717920867
        0x100032f0:    00000000    ....    DCD    0
        0x100032f4:    33323130    0123    DCD    858927408
        0x100032f8:    37363534    4567    DCD    926299444
        0x100032fc:    42413938    89AB    DCD    1111570744
        0x10003300:    46454443    CDEF    DCD    1178944579
        0x10003304:    00000000    ....    DCD    0
    $t
    i._printf_post_padding
    _printf_post_padding
        0x10003308:    e92d41f0    -..A    PUSH     {r4-r8,lr}
        0x1000330c:    4604        .F      MOV      r4,r0
        0x1000330e:    2500        .%      MOVS     r5,#0
        0x10003310:    461e        .F      MOV      r6,r3
        0x10003312:    4617        .F      MOV      r7,r2
        0x10003314:    0488        ..      LSLS     r0,r1,#18
        0x10003316:    d404        ..      BMI      0x10003322 ; _printf_post_padding + 26
        0x10003318:    e005        ..      B        0x10003326 ; _printf_post_padding + 30
        0x1000331a:    4639        9F      MOV      r1,r7
        0x1000331c:    2020                MOVS     r0,#0x20
        0x1000331e:    47b0        .G      BLX      r6
        0x10003320:    1c6d        m.      ADDS     r5,r5,#1
        0x10003322:    1e64        d.      SUBS     r4,r4,#1
        0x10003324:    d5f9        ..      BPL      0x1000331a ; _printf_post_padding + 18
        0x10003326:    4628        (F      MOV      r0,r5
        0x10003328:    e8bd81f0    ....    POP      {r4-r8,pc}
    i._printf_pre_padding
    _printf_pre_padding
        0x1000332c:    e92d41f0    -..A    PUSH     {r4-r8,lr}
        0x10003330:    4604        .F      MOV      r4,r0
        0x10003332:    2500        .%      MOVS     r5,#0
        0x10003334:    461e        .F      MOV      r6,r3
        0x10003336:    4690        .F      MOV      r8,r2
        0x10003338:    03c8        ..      LSLS     r0,r1,#15
        0x1000333a:    d501        ..      BPL      0x10003340 ; _printf_pre_padding + 20
        0x1000333c:    2730        0'      MOVS     r7,#0x30
        0x1000333e:    e000        ..      B        0x10003342 ; _printf_pre_padding + 22
        0x10003340:    2720         '      MOVS     r7,#0x20
        0x10003342:    0488        ..      LSLS     r0,r1,#18
        0x10003344:    d504        ..      BPL      0x10003350 ; _printf_pre_padding + 36
        0x10003346:    e005        ..      B        0x10003354 ; _printf_pre_padding + 40
        0x10003348:    4641        AF      MOV      r1,r8
        0x1000334a:    4638        8F      MOV      r0,r7
        0x1000334c:    47b0        .G      BLX      r6
        0x1000334e:    1c6d        m.      ADDS     r5,r5,#1
        0x10003350:    1e64        d.      SUBS     r4,r4,#1
        0x10003352:    d5f9        ..      BPL      0x10003348 ; _printf_pre_padding + 28
        0x10003354:    4628        (F      MOV      r0,r5
        0x10003356:    e8bd81f0    ....    POP      {r4-r8,pc}
    i.putc
    putc
        0x1000335a:    f7ffbc57    ..W.    B.W      fputc ; 0x10002c0c
        0x1000335e:    0000        ..      MOVS     r0,r0
    i.puts
    puts
        0x10003360:    b510        ..      PUSH     {r4,lr}
        0x10003362:    4604        .F      MOV      r4,r0
        0x10003364:    e001        ..      B        0x1000336a ; puts + 10
        0x10003366:    f7fffc51    ..Q.    BL       fputc ; 0x10002c0c
        0x1000336a:    f8140b01    ....    LDRB     r0,[r4],#1
        0x1000336e:    4904        .I      LDR      r1,[pc,#16] ; [0x10003380] = 0x2000b000
        0x10003370:    2800        .(      CMP      r0,#0
        0x10003372:    d1f8        ..      BNE      0x10003366 ; puts + 6
        0x10003374:    e8bd4010    ...@    POP      {r4,lr}
        0x10003378:    200a        .       MOVS     r0,#0xa
        0x1000337a:    f7ffbc47    ..G.    B.W      fputc ; 0x10002c0c
    $d
        0x1000337e:    0000        ..      DCW    0
        0x10003380:    2000b000    ...     DCD    536915968
    $d.realdata
    .L.str.27
        0x10003384:    4552505b    [PRE    DCD    1163022427
        0x10003388:    45534943    CISE    DCD    1163086147
        0x1000338c:    205d5252    RR]     DCD    542986834
        0x10003390:    61746164    data    DCD    1635017060
        0x10003394:    73756220     bus    DCD    1937072672
        0x10003398:    72726520     err    DCD    1920099616
        0x1000339c:    6820726f    or h    DCD    1746956911
        0x100033a0:    6f207361    as o    DCD    1864397665
        0x100033a4:    72756363    ccur    DCD    1920295779
        0x100033a8:    2c646572    red,    DCD    744777074
        0x100033ac:    20435020     PC     DCD    541282336
        0x100033b0:    7830203a    : 0x    DCD    2016419898
        0x100033b4:    78383025    %08x    DCD    2016948261
        0x100033b8:    0a0d        ..      DCW    2573
        0x100033ba:    00          .       DCB    0
    .L.str.20
        0x100033bb:    5b          [       DCB    91
        0x100033bc:    43434144    DACC    DCD    1128481092
        0x100033c0:    4c4f4956    VIOL    DCD    1280264534
        0x100033c4:    6854205d    ] Th    DCD    1750343773
        0x100033c8:    72702065    e pr    DCD    1919950949
        0x100033cc:    7365636f    oces    DCD    1936024431
        0x100033d0:    20726f73    sor     DCD    544370547
        0x100033d4:    65747461    atte    DCD    1702130785
        0x100033d8:    6574706d    mpte    DCD    1702129773
        0x100033dc:    20612064    d a     DCD    543236196
        0x100033e0:    64616f6c    load    DCD    1684107116
        0x100033e4:    20726f20     or     DCD    544370464
        0x100033e8:    726f7473    stor    DCD    1919906931
        0x100033ec:    74612065    e at    DCD    1952522341
        0x100033f0:    6c206120     a l    DCD    1814061344
        0x100033f4:    7461636f    ocat    DCD    1952539503
        0x100033f8:    206e6f69    ion     DCD    544108393
        0x100033fc:    74616874    that    DCD    1952540788
        0x10003400:    656f6420     doe    DCD    1701798944
        0x10003404:    6f6e2073    s no    DCD    1869488243
        0x10003408:    65702074    t pe    DCD    1701847156
        0x1000340c:    74696d72    rmit    DCD    1953066354
        0x10003410:    65687420     the    DCD    1701344288
        0x10003414:    65706f20     ope    DCD    1701867296
        0x10003418:    69746172    rati    DCD    1769234802
        0x1000341c:    202c6e6f    on,     DCD    539782767
        0x10003420:    3a204350    PC :    DCD    975192912
        0x10003424:    25783020     0x%    DCD    628633632
        0x10003428:    0d783830    08x.    DCD    225982512
        0x1000342c:    000a        ..      DCW    10
    .L.str.19
        0x1000342e:    495b        [I      DCW    18779
        0x10003430:    56434341    ACCV    DCD    1447248705
        0x10003434:    5d4c4f49    IOL]    DCD    1565282121
        0x10003438:    20656854    The     DCD    543516756
        0x1000343c:    636f7270    proc    DCD    1668248176
        0x10003440:    6f737365    esso    DCD    1869837157
        0x10003444:    74612072    r at    DCD    1952522354
        0x10003448:    706d6574    temp    DCD    1886217588
        0x1000344c:    20646574    ted     DCD    543450484
        0x10003450:    69206e61    an i    DCD    1763733089
        0x10003454:    7274736e    nstr    DCD    1920234350
        0x10003458:    69746375    ucti    DCD    1769235317
        0x1000345c:    66206e6f    on f    DCD    1713401455
        0x10003460:    68637465    etch    DCD    1751348325
        0x10003464:    6f726620     fro    DCD    1869768224
        0x10003468:    2061206d    m a     DCD    543236205
        0x1000346c:    61636f6c    loca    DCD    1633906540
        0x10003470:    6e6f6974    tion    DCD    1852795252
        0x10003474:    61687420     tha    DCD    1634235424
        0x10003478:    6f642074    t do    DCD    1868832884
        0x1000347c:    6e207365    es n    DCD    1847620453
        0x10003480:    7020746f    ot p    DCD    1881175151
        0x10003484:    696d7265    ermi    DCD    1768780389
        0x10003488:    78652074    t ex    DCD    2019893364
        0x1000348c:    74756365    ecut    DCD    1953850213
        0x10003490:    2c6e6f69    ion,    DCD    745434985
        0x10003494:    20435020     PC     DCD    541282336
        0x10003498:    7830203a    : 0x    DCD    2016419898
        0x1000349c:    78383025    %08x    DCD    2016948261
        0x100034a0:    0a0d        ..      DCW    2573
        0x100034a2:    00          .       DCB    0
    .L.str.21
        0x100034a3:    41          A       DCB    65
        0x100034a4:    303a2054    T :0    DCD    809115732
        0x100034a8:    38302578    x%08    DCD    942679416
        0x100034ac:    000a0d78    x...    DCD    658808
    .L.str.1
        0x100034b0:    7261485b    [Har    DCD    1918978139
        0x100034b4:    75614664    dFau    DCD    1969309284
        0x100034b8:    485f746c    lt_H    DCD    1214215276
        0x100034bc:    6c646e61    andl    DCD    1818521185
        0x100034c0:    435d7265    er]C    DCD    1130197605
        0x100034c4:    65727275    urre    DCD    1701999221
        0x100034c8:    6d20746e    nt m    DCD    1830843502
        0x100034cc:    203a7073    sp:     DCD    540700787
        0x100034d0:    30257830    0x%0    DCD    807761968
        0x100034d4:    000a5838    8X..    DCD    677944
    .Lstr.68
        0x100034d8:    564e495b    [INV    DCD    1447971163
        0x100034dc:    615d4350    PC]a    DCD    1633502032
        0x100034e0:    6e69206e    n in    DCD    1852383342
        0x100034e4:    72676574    tegr    DCD    1919378804
        0x100034e8:    20797469    ity     DCD    544830569
        0x100034ec:    63656863    chec    DCD    1667590243
        0x100034f0:    7265206b    k er    DCD    1919230059
        0x100034f4:    20726f72    ror     DCD    544370546
        0x100034f8:    20736168    has     DCD    544432488
        0x100034fc:    7563636f    occu    DCD    1969447791
        0x10003500:    64657272    rred    DCD    1684370034
        0x10003504:    000d        ..      DCW    13
    .Lstr.66
        0x10003506:    555b        [U      DCW    21851
        0x10003508:    4645444e    NDEF    DCD    1178944590
        0x1000350c:    54534e49    INST    DCD    1414745673
        0x10003510:    6e615d52    R]an    DCD    1851874642
        0x10003514:    646e7520     und    DCD    1684960544
        0x10003518:    6e696665    efin    DCD    1852401253
        0x1000351c:    69206465    ed i    DCD    1763730533
        0x10003520:    7274736e    nstr    DCD    1920234350
        0x10003524:    69746375    ucti    DCD    1769235317
        0x10003528:    65206e6f    on e    DCD    1696624239
        0x1000352c:    726f7272    rror    DCD    1919906418
        0x10003530:    73616820     has    DCD    1935763488
        0x10003534:    63636f20     occ    DCD    1667460896
        0x10003538:    65727275    urre    DCD    1701999221
        0x1000353c:    0d64        d.      DCW    3428
        0x1000353e:    00          .       DCB    0
    .Lstr.72
        0x1000353f:    5b          [       DCB    91
        0x10003540:    42564944    DIVB    DCD    1112951108
        0x10003544:    52455a59    YZER    DCD    1380276825
        0x10003548:    6e615d4f    O]an    DCD    1851874639
        0x1000354c:    746e6920     int    DCD    1953392928
        0x10003550:    72656765    eger    DCD    1919248229
        0x10003554:    76696420     div    DCD    1986618400
        0x10003558:    6f697369    isio    DCD    1869181801
        0x1000355c:    7962206e    n by    DCD    2036473966
        0x10003560:    72657a20     zer    DCD    1919253024
        0x10003564:    7265206f    o er    DCD    1919230063
        0x10003568:    20726f72    ror     DCD    544370546
        0x1000356c:    20736168    has     DCD    544432488
        0x10003570:    7563636f    occu    DCD    1969447791
        0x10003574:    64657272    rred    DCD    1684370034
        0x10003578:    000d        ..      DCW    13
    .Lstr.61
        0x1000357a:    495b        [I      DCW    18779
        0x1000357c:    4552504d    MPRE    DCD    1163022413
        0x10003580:    45534943    CISE    DCD    1163086147
        0x10003584:    495d5252    RR]I    DCD    1230852690
        0x10003588:    6572706d    mpre    DCD    1701998701
        0x1000358c:    65736963    cise    DCD    1702062435
        0x10003590:    74616420     dat    DCD    1952539680
        0x10003594:    63612061    a ac    DCD    1667309665
        0x10003598:    73736563    cess    DCD    1936942435
        0x1000359c:    72726520     err    DCD    1920099616
        0x100035a0:    6820726f    or h    DCD    1746956911
        0x100035a4:    6f207361    as o    DCD    1864397665
        0x100035a8:    72756363    ccur    DCD    1920295779
        0x100035ac:    0d646572    red.    DCD    224683378
        0x100035b0:    00          .       DCB    0
    .Lstr.71
        0x100035b1:    5b554e      [UN     DCB    91,85,78
        0x100035b4:    47494c41    ALIG    DCD    1195985985
        0x100035b8:    5d44454e    NED]    DCD    1564755278
        0x100035bc:    75206e61    an u    DCD    1965059681
        0x100035c0:    696c616e    nali    DCD    1768710510
        0x100035c4:    64656e67    gned    DCD    1684368999
        0x100035c8:    63636120     acc    DCD    1667457312
        0x100035cc:    20737365    ess     DCD    544437093
        0x100035d0:    6f727265    erro    DCD    1869771365
        0x100035d4:    61682072    r ha    DCD    1634214002
        0x100035d8:    636f2073    s oc    DCD    1668227187
        0x100035dc:    72727563    curr    DCD    1920103779
        0x100035e0:    000d6465    ed..    DCD    877669
    .Lstr.60
        0x100035e4:    5542495b    [IBU    DCD    1430407515
        0x100035e8:    52524553    SERR    DCD    1381123411
        0x100035ec:    736e695d    ]ins    DCD    1936615773
        0x100035f0:    63757274    truc    DCD    1668641396
        0x100035f4:    6e6f6974    tion    DCD    1852795252
        0x100035f8:    73756220     bus    DCD    1937072672
        0x100035fc:    72726520     err    DCD    1920099616
        0x10003600:    6820726f    or h    DCD    1746956911
        0x10003604:    6f207361    as o    DCD    1864397665
        0x10003608:    72756363    ccur    DCD    1920295779
        0x1000360c:    0d646572    red.    DCD    224683378
        0x10003610:    00          .       DCB    0
    .Lstr.69
        0x10003611:    5b4e4f      [NO     DCB    91,78,79
        0x10003614:    615d5043    CP]a    DCD    1633505347
        0x10003618:    706f6320     cop    DCD    1886348064
        0x1000361c:    65636f72    roce    DCD    1701015410
        0x10003620:    726f7373    ssor    DCD    1919906675
        0x10003624:    73696420     dis    DCD    1936286752
        0x10003628:    656c6261    able    DCD    1701601889
        0x1000362c:    726f2064    d or    DCD    1919885412
        0x10003630:    746f6e20     not    DCD    1953459744
        0x10003634:    65727020     pre    DCD    1701998624
        0x10003638:    746e6573    sent    DCD    1953391987
        0x1000363c:    72726520     err    DCD    1920099616
        0x10003640:    6820726f    or h    DCD    1746956911
        0x10003644:    6f207361    as o    DCD    1864397665
        0x10003648:    72756363    ccur    DCD    1920295779
        0x1000364c:    0d646572    red.    DCD    224683378
        0x10003650:    00          .       DCB    0
    .Lstr.70
        0x10003651:    5b5354      [ST     DCB    91,83,84
        0x10003654:    5d464f4b    KOF]    DCD    1564888907
        0x10003658:    74732061    a st    DCD    1953701985
        0x1000365c:    206b6361    ack     DCD    543908705
        0x10003660:    7265766f    over    DCD    1919252079
        0x10003664:    776f6c66    flow    DCD    2003790950
        0x10003668:    72726520     err    DCD    1920099616
        0x1000366c:    6820726f    or h    DCD    1746956911
        0x10003670:    6f207361    as o    DCD    1864397665
        0x10003674:    72756363    ccur    DCD    1920295779
        0x10003678:    0d646572    red.    DCD    224683378
        0x1000367c:    00          .       DCB    0
    .Lstr.67
        0x1000367d:    5b494e      [IN     DCB    91,73,78
        0x10003680:    41545356    VSTA    DCD    1096045398
        0x10003684:    205d4554    TE]     DCD    542983508
        0x10003688:    45206e61    an E    DCD    1159753313
        0x1000368c:    2e525350    PSR.    DCD    777147216
        0x10003690:    726f2054    T or    DCD    1919885396
        0x10003694:    53504520     EPS    DCD    1397769504
        0x10003698:    54492e52    R.IT    DCD    1414082130
        0x1000369c:    6c617620     val    DCD    1818326560
        0x100036a0:    74696469    idit    DCD    1953064041
        0x100036a4:    72652079    y er    DCD    1919230073
        0x100036a8:    20726f72    ror     DCD    544370546
        0x100036ac:    20736168    has     DCD    544432488
        0x100036b0:    7563636f    occu    DCD    1969447791
        0x100036b4:    64657272    rred    DCD    1684370034
        0x100036b8:    000d        ..      DCW    13
    .Lstr.58
        0x100036ba:    4d5b        [M      DCW    19803
        0x100036bc:    4550534c    LSPE    DCD    1162892108
        0x100036c0:    415d5252    RR]A    DCD    1096634962
        0x100036c4:    6d654d20     Mem    DCD    1835355424
        0x100036c8:    616e614d    Mana    DCD    1634623821
        0x100036cc:    66206567    ge f    DCD    1713399143
        0x100036d0:    746c7561    ault    DCD    1953264993
        0x100036d4:    63636f20     occ    DCD    1667460896
        0x100036d8:    65727275    urre    DCD    1701999221
        0x100036dc:    75642064    d du    DCD    1969496164
        0x100036e0:    676e6972    ring    DCD    1735289202
        0x100036e4:    6f6c6620     flo    DCD    1869375008
        0x100036e8:    6e697461    atin    DCD    1852404833
        0x100036ec:    6f702d67    g-po    DCD    1869622631
        0x100036f0:    20746e69    int     DCD    544501353
        0x100036f4:    797a616c    lazy    DCD    2038063468
        0x100036f8:    61747320     sta    DCD    1635021600
        0x100036fc:    70206574    te p    DCD    1881171316
        0x10003700:    65736572    rese    DCD    1702061426
        0x10003704:    74617672    rvat    DCD    1952544370
        0x10003708:    0d6e6f69    ion.    DCD    225341289
        0x1000370c:    00          .       DCB    0
    .Lstr.64
        0x1000370d:    5b4c53      [LS     DCB    91,76,83
        0x10003710:    52524550    PERR    DCD    1381123408
        0x10003714:    6220415d    ]A b    DCD    1646281053
        0x10003718:    66207375    us f    DCD    1713402741
        0x1000371c:    746c7561    ault    DCD    1953264993
        0x10003720:    63636f20     occ    DCD    1667460896
        0x10003724:    65727275    urre    DCD    1701999221
        0x10003728:    75642064    d du    DCD    1969496164
        0x1000372c:    676e6972    ring    DCD    1735289202
        0x10003730:    6f6c6620     flo    DCD    1869375008
        0x10003734:    6e697461    atin    DCD    1852404833
        0x10003738:    6f702d67    g-po    DCD    1869622631
        0x1000373c:    20746e69    int     DCD    544501353
        0x10003740:    797a616c    lazy    DCD    2038063468
        0x10003744:    61747320     sta    DCD    1635021600
        0x10003748:    70206574    te p    DCD    1881171316
        0x1000374c:    65736572    rese    DCD    1702061426
        0x10003750:    74617672    rvat    DCD    1952544370
        0x10003754:    0d6e6f69    ion.    DCD    225341289
        0x10003758:    00          .       DCB    0
    .Lstr.56
        0x10003759:    5b4d55      [MU     DCB    91,77,85
        0x1000375c:    4b54534e    NSTK    DCD    1263817550
        0x10003760:    5d525245    ERR]    DCD    1565676101
        0x10003764:    74736e55    Unst    DCD    1953721941
        0x10003768:    206b6361    ack     DCD    543908705
        0x1000376c:    20726f66    for     DCD    544370534
        0x10003770:    65206e61    an e    DCD    1696624225
        0x10003774:    70656378    xcep    DCD    1885692792
        0x10003778:    6e6f6974    tion    DCD    1852795252
        0x1000377c:    74657220     ret    DCD    1952805408
        0x10003780:    206e7275    urn     DCD    544109173
        0x10003784:    20736168    has     DCD    544432488
        0x10003788:    73756163    caus    DCD    1937072483
        0x1000378c:    6f206465    ed o    DCD    1864393829
        0x10003790:    6f20656e    ne o    DCD    1864394094
        0x10003794:    6f6d2072    r mo    DCD    1869422706
        0x10003798:    61206572    re a    DCD    1629513074
        0x1000379c:    73656363    cces    DCD    1936024419
        0x100037a0:    69762073    s vi    DCD    1769349235
        0x100037a4:    74616c6f    olat    DCD    1952541807
        0x100037a8:    736e6f69    ions    DCD    1936617321
        0x100037ac:    000d        ..      DCW    13
    .Lstr.57
        0x100037ae:    4d5b        [M      DCW    19803
        0x100037b0:    454b5453    STKE    DCD    1162564691
        0x100037b4:    535d5252    RR]S    DCD    1398624850
        0x100037b8:    6b636174    tack    DCD    1801675124
        0x100037bc:    20676e69    ing     DCD    543649385
        0x100037c0:    20726f66    for     DCD    544370534
        0x100037c4:    65206e61    an e    DCD    1696624225
        0x100037c8:    70656378    xcep    DCD    1885692792
        0x100037cc:    6e6f6974    tion    DCD    1852795252
        0x100037d0:    746e6520     ent    DCD    1953391904
        0x100037d4:    68207972    ry h    DCD    1746958706
        0x100037d8:    63207361    as c    DCD    1663071073
        0x100037dc:    65737561    ause    DCD    1702065505
        0x100037e0:    6e6f2064    d on    DCD    1852776548
        0x100037e4:    726f2065    e or    DCD    1919885413
        0x100037e8:    726f6d20     mor    DCD    1919905056
        0x100037ec:    63612065    e ac    DCD    1667309669
        0x100037f0:    73736563    cess    DCD    1936942435
        0x100037f4:    6f697620     vio    DCD    1869182496
        0x100037f8:    6974616c    lati    DCD    1769234796
        0x100037fc:    0d736e6f    ons.    DCD    225668719
        0x10003800:    00          .       DCB    0
    .Lstr.62
        0x10003801:    5b554e      [UN     DCB    91,85,78
        0x10003804:    454b5453    STKE    DCD    1162564691
        0x10003808:    555d5252    RR]U    DCD    1432179282
        0x1000380c:    6174736e    nsta    DCD    1635021678
        0x10003810:    66206b63    ck f    DCD    1713400675
        0x10003814:    6120726f    or a    DCD    1629516399
        0x10003818:    7865206e    n ex    DCD    2019893358
        0x1000381c:    74706563    cept    DCD    1953523043
        0x10003820:    206e6f69    ion     DCD    544108393
        0x10003824:    75746572    retu    DCD    1970562418
        0x10003828:    68206e72    rn h    DCD    1746955890
        0x1000382c:    63207361    as c    DCD    1663071073
        0x10003830:    65737561    ause    DCD    1702065505
        0x10003834:    6e6f2064    d on    DCD    1852776548
        0x10003838:    726f2065    e or    DCD    1919885413
        0x1000383c:    726f6d20     mor    DCD    1919905056
        0x10003840:    75422065    e Bu    DCD    1967267941
        0x10003844:    75614673    sFau    DCD    1969309299
        0x10003848:    0d73746c    lts.    DCD    225670252
        0x1000384c:    00          .       DCB    0
    .Lstr.63
        0x1000384d:    5b5354      [ST     DCB    91,83,84
        0x10003850:    5252454b    KERR    DCD    1381123403
        0x10003854:    6174535d    ]Sta    DCD    1635013469
        0x10003858:    6e696b63    ckin    DCD    1852402531
        0x1000385c:    6f662067    g fo    DCD    1868963943
        0x10003860:    6e612072    r an    DCD    1851859058
        0x10003864:    63786520     exc    DCD    1668834592
        0x10003868:    69747065    epti    DCD    1769238629
        0x1000386c:    65206e6f    on e    DCD    1696624239
        0x10003870:    7972746e    ntry    DCD    2037544046
        0x10003874:    73616820     has    DCD    1935763488
        0x10003878:    75616320     cau    DCD    1969316640
        0x1000387c:    20646573    sed     DCD    543450483
        0x10003880:    20656e6f    one     DCD    543518319
        0x10003884:    6d20726f    or m    DCD    1830842991
        0x10003888:    2065726f    ore     DCD    543519343
        0x1000388c:    46737542    BusF    DCD    1181971778
        0x10003890:    746c7561    ault    DCD    1953264993
        0x10003894:    0d73        s.      DCW    3443
        0x10003896:    00          .       DCB    0
    .Lstr.55
        0x10003897:    4d          M       DCB    77
        0x10003898:    614d6d65    emMa    DCD    1632464229
        0x1000389c:    6567616e    nage    DCD    1701273966
        0x100038a0:    75614620     Fau    DCD    1969309216
        0x100038a4:    000d746c    lt..    DCD    881772
    .Lstr.65
        0x100038a8:    67617355    Usag    DCD    1734439765
        0x100038ac:    61462065    e Fa    DCD    1631985765
        0x100038b0:    0d746c75    ult.    DCD    225733749
        0x100038b4:    00          .       DCB    0
    .Lstr.54
        0x100038b5:    436f6e      Con     DCB    67,111,110
        0x100038b8:    75676966    figu    DCD    1969711462
        0x100038bc:    6c626172    rabl    DCD    1818386802
        0x100038c0:    61462065    e Fa    DCD    1631985765
        0x100038c4:    0d746c75    ult.    DCD    225733749
        0x100038c8:    00          .       DCB    0
    .Lstr.52
        0x100038c9:    566563      Vec     DCB    86,101,99
        0x100038cc:    20726f74    tor     DCD    544370548
        0x100038d0:    6c756146    Faul    DCD    1819631942
        0x100038d4:    0d74        t.      DCW    3444
        0x100038d6:    00          .       DCB    0
    .Lstr.59
        0x100038d7:    42          B       DCB    66
        0x100038d8:    46207375    us F    DCD    1176531829
        0x100038dc:    746c7561    ault    DCD    1953264993
        0x100038e0:    000d        ..      DCW    13
    .Lstr.53
        0x100038e2:    6544        De      DCW    25924
        0x100038e4:    20677562    bug     DCD    543651170
        0x100038e8:    6e657645    Even    DCD    1852143173
        0x100038ec:    61462074    t Fa    DCD    1631985780
        0x100038f0:    0d746c75    ult.    DCD    225733749
        0x100038f4:    00          .       DCB    0
    .Lstr.48
        0x100038f5:    4f6363      Occ     DCB    79,99,99
        0x100038f8:    64657275    ured    DCD    1684370037
        0x100038fc:    206e6920     in     DCD    544106784
        0x10003900:    6b736174    task    DCD    1802723700
        0x10003904:    002e        ..      DCW    46
    .Lstr.49
        0x10003906:    7355        Us      DCW    29525
        0x10003908:    20676e69    ing     DCD    543649385
        0x1000390c:    4d323375    u32M    DCD    1295135605
        0x10003910:    002e7073    sp..    DCD    3043443
    .Lstr
        0x10003914:    7563634f    Occu    DCD    1969447759
        0x10003918:    20646572    red     DCD    543450482
        0x1000391c:    69206e69    in i    DCD    1763733097
        0x10003920:    7265746e    nter    DCD    1919251566
        0x10003924:    74707572    rupt    DCD    1953527154
        0x10003928:    0000002e    ....    DCD    46

** Section #4 'RAM_VECTOR' (SHT_NOBITS) [SHF_ALLOC + SHF_WRITE]
    Size   : 300 bytes (alignment 512)
    Address: 0x20003000


** Section #5 'RAM_CODE' (SHT_PROGBITS) [SHF_ALLOC + SHF_EXECINSTR]
    Size   : 268 bytes (alignment 4)
    Address: 0x20003200

    $t
    DMA_IRQ0_Handler
        0x20003200:    b5b0        ..      PUSH     {r4,r5,r7,lr}
        0x20003202:    b082        ..      SUB      sp,sp,#8
        0x20003204:    f2480400    H...    MOVW     r4,#0x8000
        0x20003208:    2000        .       MOVS     r0,#0
        0x2000320a:    f2c50400    ....    MOVT     r4,#0x5000
        0x2000320e:    f88d0007    ....    STRB     r0,[sp,#7]
        0x20003212:    f10d0107    ....    ADD      r1,sp,#7
        0x20003216:    4620         F      MOV      r0,r4
        0x20003218:    f000f855    ..U.    BL       $Ven$TT$L$$rom_hw_dma_get_interrupt_flag ; 0x200032c6
        0x2000321c:    f89d1007    ....    LDRB     r1,[sp,#7]
        0x20003220:    4620         F      MOV      r0,r4
        0x20003222:    f000f855    ..U.    BL       $Ven$TT$L$$rom_hw_dma_clear_interrupt_flag ; 0x200032d0
        0x20003226:    f89d0007    ....    LDRB     r0,[sp,#7]
        0x2000322a:    0780        ..      LSLS     r0,r0,#30
        0x2000322c:    d549        I.      BPL      0x200032c2 ; DMA_IRQ0_Handler + 194
        0x2000322e:    f24d0c20    M. .    MOV      r12,#0xd020
        0x20003232:    f2c20c00    ....    MOVT     r12,#0x2000
        0x20003236:    f24d0148    M.H.    MOV      r1,#0xd048
        0x2000323a:    f89c0000    ....    LDRB     r0,[r12,#0]
        0x2000323e:    f2c20100    ....    MOVT     r1,#0x2000
        0x20003242:    f04f0e01    O...    MOV      lr,#1
        0x20003246:    780b        .x      LDRB     r3,[r1,#0]
        0x20003248:    f0800501    ....    EOR      r5,r0,#1
        0x2000324c:    fa0ef200    ....    LSL      r2,lr,r0
        0x20003250:    421a        .B      TST      r2,r3
        0x20003252:    fa0ef305    ....    LSL      r3,lr,r5
        0x20003256:    f24d0e44    M.D.    MOV      lr,#0xd044
        0x2000325a:    f2c20e00    ....    MOVT     lr,#0x2000
        0x2000325e:    d004        ..      BEQ      0x2000326a ; DMA_IRQ0_Handler + 106
        0x20003260:    f8de0000    ....    LDR      r0,[lr,#0]
        0x20003264:    3001        .0      ADDS     r0,#1
        0x20003266:    f8ce0000    ....    STR      r0,[lr,#0]
        0x2000326a:    7808        .x      LDRB     r0,[r1,#0]
        0x2000326c:    4203        .B      TST      r3,r0
        0x2000326e:    d007        ..      BEQ      0x20003280 ; DMA_IRQ0_Handler + 128
        0x20003270:    f8de0000    ....    LDR      r0,[lr,#0]
        0x20003274:    3001        .0      ADDS     r0,#1
        0x20003276:    f8ce0000    ....    STR      r0,[lr,#0]
        0x2000327a:    7808        .x      LDRB     r0,[r1,#0]
        0x2000327c:    4398        .C      BICS     r0,r0,r3
        0x2000327e:    7008        .p      STRB     r0,[r1,#0]
        0x20003280:    7808        .x      LDRB     r0,[r1,#0]
        0x20003282:    4310        .C      ORRS     r0,r0,r2
        0x20003284:    7008        .p      STRB     r0,[r1,#0]
        0x20003286:    4620         F      MOV      r0,r4
        0x20003288:    f88c5000    ...P    STRB     r5,[r12,#0]
        0x2000328c:    f000f825    ..%.    BL       $Ven$TT$L$$rom_hw_dma_disable ; 0x200032da
        0x20003290:    f24b001c    K...    MOV      r0,#0xb01c
        0x20003294:    f2c20000    ....    MOVT     r0,#0x2000
        0x20003298:    eb003005    ...0    ADD      r0,r0,r5,LSL #12
        0x2000329c:    f24d0124    M.$.    MOV      r1,#0xd024
        0x200032a0:    f2c20100    ....    MOVT     r1,#0x2000
        0x200032a4:    6048        H`      STR      r0,[r1,#4]
        0x200032a6:    4620         F      MOV      r0,r4
        0x200032a8:    f000f81c    ....    BL       $Ven$TT$L$$rom_hw_dma_init ; 0x200032e4
        0x200032ac:    4620         F      MOV      r0,r4
        0x200032ae:    2100        .!      MOVS     r1,#0
        0x200032b0:    f000f81d    ....    BL       $Ven$TT$L$$rom_hw_dma_set_interrupt_channel ; 0x200032ee
        0x200032b4:    4620         F      MOV      r0,r4
        0x200032b6:    2102        .!      MOVS     r1,#2
        0x200032b8:    f000f81e    ....    BL       $Ven$TT$L$$rom_hw_dma_enable_interrupt ; 0x200032f8
        0x200032bc:    4620         F      MOV      r0,r4
        0x200032be:    f000f820    .. .    BL       $Ven$TT$L$$rom_hw_dma_enable ; 0x20003302
        0x200032c2:    b002        ..      ADD      sp,sp,#8
        0x200032c4:    bdb0        ..      POP      {r4,r5,r7,pc}
    $Ven$TT$L$$rom_hw_dma_get_interrupt_flag
        0x200032c6:    f2482c1d    H..,    MOV      r12,#0x821d
        0x200032ca:    f2c00c00    ....    MOVT     r12,#0
        0x200032ce:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_dma_clear_interrupt_flag
        0x200032d0:    f2480c59    H.Y.    MOV      r12,#0x8059
        0x200032d4:    f2c00c00    ....    MOVT     r12,#0
        0x200032d8:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_dma_disable
        0x200032da:    f2480cad    H...    MOV      r12,#0x80ad
        0x200032de:    f2c00c00    ....    MOVT     r12,#0
        0x200032e2:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_dma_init
        0x200032e4:    f2483c65    H.e<    MOV      r12,#0x8365
        0x200032e8:    f2c00c00    ....    MOVT     r12,#0
        0x200032ec:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_dma_set_interrupt_channel
        0x200032ee:    f2484cf1    H..L    MOV      r12,#0x84f1
        0x200032f2:    f2c00c00    ....    MOVT     r12,#0
        0x200032f6:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_dma_enable_interrupt
        0x200032f8:    f2481c35    H.5.    MOV      r12,#0x8135
        0x200032fc:    f2c00c00    ....    MOVT     r12,#0
        0x20003300:    4760        `G      BX       r12
    $Ven$TT$L$$rom_hw_dma_enable
        0x20003302:    f2481c15    H...    MOV      r12,#0x8115
        0x20003306:    f2c00c00    ....    MOVT     r12,#0
        0x2000330a:    4760        `G      BX       r12

** Section #6 'RAM_DATA' (SHT_PROGBITS) [SHF_ALLOC + SHF_WRITE]
    Size   : 4 bytes (alignment 4)
    Address: 0x2000b000


** Section #7 'RAM_DATA' (SHT_NOBITS) [SHF_ALLOC + SHF_WRITE]
    Size   : 8268 bytes (alignment 4)
    Address: 0x2000b004


** Section #8 'RAM_STACK_HEAP' (SHT_NOBITS) [SHF_ALLOC + SHF_WRITE]
    Size   : 4096 bytes (alignment 8)
    Address: 0x2000f000


** Section #9 '.debug_abbrev' (SHT_PROGBITS)
    Size   : 2706 bytes


** Section #10 '.debug_frame' (SHT_PROGBITS)
    Size   : 2736 bytes


** Section #11 '.debug_info' (SHT_PROGBITS)
    Size   : 16910 bytes


** Section #12 '.debug_line' (SHT_PROGBITS)
    Size   : 5510 bytes


** Section #13 '.debug_loc' (SHT_PROGBITS)
    Size   : 3105 bytes


** Section #14 '.debug_ranges' (SHT_PROGBITS)
    Size   : 448 bytes


** Section #15 '.debug_str' (SHT_PROGBITS)
    Size   : 19465 bytes


** Section #16 '.symtab' (SHT_SYMTAB)
    Size   : 19072 bytes (alignment 4)
    String table #17 '.strtab'
    Last local symbol no. 161


** Section #17 '.strtab' (SHT_STRTAB)
    Size   : 27276 bytes


** Section #18 '.note' (SHT_NOTE)
    Size   : 48 bytes (alignment 4)


** Section #19 '.comment' (SHT_PROGBITS)
    Size   : 1572 bytes


** Section #20 '.shstrtab' (SHT_STRTAB)
    Size   : 208 bytes


