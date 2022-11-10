 
****************************************
Report : resources
Design : QR_CORDIC
Version: N-2017.09-SP2
Date   : Thu Sep 22 11:37:28 2022
****************************************


Resource Report for this hierarchy in file /home/rain/QR_CORDIC/QR_CORDIC.v
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| mult_x_1       | DW_mult_tc     | a_width=13 | mult_101 (QR_CORDIC.v:101) |
|                |                | b_width=11 |                            |
| mult_x_2       | DW_mult_tc     | a_width=13 | mult_102 (QR_CORDIC.v:102) |
|                |                | b_width=11 |                            |
| mult_x_3       | DW_mult_tc     | a_width=13 | mult_103 (QR_CORDIC.v:103) |
|                |                | b_width=11 |                            |
| mult_x_4       | DW_mult_tc     | a_width=13 | mult_104 (QR_CORDIC.v:104) |
|                |                | b_width=11 |                            |
| sub_x_5        | DW01_dec       | width=3    | sub_106 (QR_CORDIC.v:106)  |
| sub_x_6        | DW01_dec       | width=3    | sub_107 (QR_CORDIC.v:107)  |
| sub_x_7        | DW01_dec       | width=3    | sub_108 (QR_CORDIC.v:108)  |
| sub_x_8        | DW01_dec       | width=3    | sub_109 (QR_CORDIC.v:109)  |
| add_x_9        | DW01_add       | width=3    | add_111 (QR_CORDIC.v:111)  |
| add_x_10       | DW01_add       | width=3    | add_112 (QR_CORDIC.v:112)  |
| add_x_11       | DW01_add       | width=3    | add_113 (QR_CORDIC.v:113)  |
| add_x_12       | DW01_add       | width=3    | add_114 (QR_CORDIC.v:114)  |
| add_x_753      | DW01_inc       | width=3    | inst_GG1/add_11 (VECTOR_MODE.v:11) |
| add_x_758      | DW01_inc       | width=3    | inst_GR1/add_11 (ROTATION_MODE.v:11) |
| add_x_763      | DW01_inc       | width=3    | inst_GR6/add_11 (ROTATION_MODE.v:11) |
| add_x_768      | DW01_inc       | width=3    | inst_GR5/add_11 (ROTATION_MODE.v:11) |
| add_x_773      | DW01_inc       | width=3    | inst_GR4/add_11 (ROTATION_MODE.v:11) |
| add_x_778      | DW01_inc       | width=3    | inst_GR3/add_11 (ROTATION_MODE.v:11) |
| add_x_783      | DW01_inc       | width=3    | inst_GR2/add_11 (ROTATION_MODE.v:11) |
| add_x_788      | DW01_inc       | width=3    | inst_GG4/add_11 (VECTOR_MODE.v:11) |
| add_x_793      | DW01_inc       | width=3    | inst_GG3/add_11 (VECTOR_MODE.v:11) |
| add_x_798      | DW01_inc       | width=3    | inst_GG2/add_11 (VECTOR_MODE.v:11) |
| ashr_754       | DW_rightsh     | A_width=13 | inst_GG1/sra_14 (VECTOR_MODE.v:14) |
         |                | SH_width=3 | inst_GG1/sra_14_2 (VECTOR_MODE.v:14) |
| ashr_755       | DW_rightsh     | A_width=13 | inst_GG1/sra_15 (VECTOR_MODE.v:15) |
         |                | SH_width=3 | inst_GG1/sra_15_2 (VECTOR_MODE.v:15) |
| ashr_756       | DW_rightsh     | A_width=13 | inst_GG1/sra_20 (VECTOR_MODE.v:20) |
         |                | SH_width=3 | inst_GG1/sra_20_2 (VECTOR_MODE.v:20) |
| ashr_757       | DW_rightsh     | A_width=13 | inst_GG1/sra_21 (VECTOR_MODE.v:21) |
         |                | SH_width=3 | inst_GG1/sra_21_2 (VECTOR_MODE.v:21) |
| ashr_759       | DW_rightsh     | A_width=13 | inst_GR1/sra_13 (ROTATION_MODE.v:13) |
       |                | SH_width=3 | inst_GR1/sra_13_2 (ROTATION_MODE.v:13) |
| ashr_760       | DW_rightsh     | A_width=13 | inst_GR1/sra_14 (ROTATION_MODE.v:14) |
       |                | SH_width=3 | inst_GR1/sra_14_2 (ROTATION_MODE.v:14) |
| ashr_761       | DW_rightsh     | A_width=13 | inst_GR1/sra_16 (ROTATION_MODE.v:16) |
       |                | SH_width=3 | inst_GR1/sra_16_2 (ROTATION_MODE.v:16) |
| ashr_762       | DW_rightsh     | A_width=13 | inst_GR1/sra_17 (ROTATION_MODE.v:17) |
       |                | SH_width=3 | inst_GR1/sra_17_2 (ROTATION_MODE.v:17) |
| ashr_764       | DW_rightsh     | A_width=13 | inst_GR6/sra_13 (ROTATION_MODE.v:13) |
       |                | SH_width=3 | inst_GR6/sra_13_2 (ROTATION_MODE.v:13) |
| ashr_765       | DW_rightsh     | A_width=13 | inst_GR6/sra_14 (ROTATION_MODE.v:14) |
       |                | SH_width=3 | inst_GR6/sra_14_2 (ROTATION_MODE.v:14) |
| ashr_766       | DW_rightsh     | A_width=13 | inst_GR6/sra_16 (ROTATION_MODE.v:16) |
       |                | SH_width=3 | inst_GR6/sra_16_2 (ROTATION_MODE.v:16) |
| ashr_767       | DW_rightsh     | A_width=13 | inst_GR6/sra_17 (ROTATION_MODE.v:17) |
       |                | SH_width=3 | inst_GR6/sra_17_2 (ROTATION_MODE.v:17) |
| ashr_769       | DW_rightsh     | A_width=13 | inst_GR5/sra_13 (ROTATION_MODE.v:13) |
       |                | SH_width=3 | inst_GR5/sra_13_2 (ROTATION_MODE.v:13) |
| ashr_770       | DW_rightsh     | A_width=13 | inst_GR5/sra_14 (ROTATION_MODE.v:14) |
       |                | SH_width=3 | inst_GR5/sra_14_2 (ROTATION_MODE.v:14) |
| ashr_771       | DW_rightsh     | A_width=13 | inst_GR5/sra_16 (ROTATION_MODE.v:16) |
       |                | SH_width=3 | inst_GR5/sra_16_2 (ROTATION_MODE.v:16) |
| ashr_772       | DW_rightsh     | A_width=13 | inst_GR5/sra_17 (ROTATION_MODE.v:17) |
       |                | SH_width=3 | inst_GR5/sra_17_2 (ROTATION_MODE.v:17) |
| ashr_774       | DW_rightsh     | A_width=13 | inst_GR4/sra_13 (ROTATION_MODE.v:13) |
       |                | SH_width=3 | inst_GR4/sra_13_2 (ROTATION_MODE.v:13) |
| ashr_775       | DW_rightsh     | A_width=13 | inst_GR4/sra_14 (ROTATION_MODE.v:14) |
       |                | SH_width=3 | inst_GR4/sra_14_2 (ROTATION_MODE.v:14) |
| ashr_776       | DW_rightsh     | A_width=13 | inst_GR4/sra_16 (ROTATION_MODE.v:16) |
       |                | SH_width=3 | inst_GR4/sra_16_2 (ROTATION_MODE.v:16) |
| ashr_777       | DW_rightsh     | A_width=13 | inst_GR4/sra_17 (ROTATION_MODE.v:17) |
       |                | SH_width=3 | inst_GR4/sra_17_2 (ROTATION_MODE.v:17) |
| ashr_779       | DW_rightsh     | A_width=13 | inst_GR3/sra_13 (ROTATION_MODE.v:13) |
       |                | SH_width=3 | inst_GR3/sra_13_2 (ROTATION_MODE.v:13) |
| ashr_780       | DW_rightsh     | A_width=13 | inst_GR3/sra_14 (ROTATION_MODE.v:14) |
       |                | SH_width=3 | inst_GR3/sra_14_2 (ROTATION_MODE.v:14) |
| ashr_781       | DW_rightsh     | A_width=13 | inst_GR3/sra_16 (ROTATION_MODE.v:16) |
       |                | SH_width=3 | inst_GR3/sra_16_2 (ROTATION_MODE.v:16) |
| ashr_782       | DW_rightsh     | A_width=13 | inst_GR3/sra_17 (ROTATION_MODE.v:17) |
       |                | SH_width=3 | inst_GR3/sra_17_2 (ROTATION_MODE.v:17) |
| ashr_784       | DW_rightsh     | A_width=13 | inst_GR2/sra_13 (ROTATION_MODE.v:13) |
       |                | SH_width=3 | inst_GR2/sra_13_2 (ROTATION_MODE.v:13) |
| ashr_785       | DW_rightsh     | A_width=13 | inst_GR2/sra_14 (ROTATION_MODE.v:14) |
       |                | SH_width=3 | inst_GR2/sra_14_2 (ROTATION_MODE.v:14) |
| ashr_786       | DW_rightsh     | A_width=13 | inst_GR2/sra_16 (ROTATION_MODE.v:16) |
       |                | SH_width=3 | inst_GR2/sra_16_2 (ROTATION_MODE.v:16) |
| ashr_787       | DW_rightsh     | A_width=13 | inst_GR2/sra_17 (ROTATION_MODE.v:17) |
       |                | SH_width=3 | inst_GR2/sra_17_2 (ROTATION_MODE.v:17) |
| ashr_789       | DW_rightsh     | A_width=13 | inst_GG4/sra_14 (VECTOR_MODE.v:14) |
         |                | SH_width=3 | inst_GG4/sra_14_2 (VECTOR_MODE.v:14) |
| ashr_790       | DW_rightsh     | A_width=13 | inst_GG4/sra_15 (VECTOR_MODE.v:15) |
         |                | SH_width=3 | inst_GG4/sra_15_2 (VECTOR_MODE.v:15) |
| ashr_791       | DW_rightsh     | A_width=13 | inst_GG4/sra_20 (VECTOR_MODE.v:20) |
         |                | SH_width=3 | inst_GG4/sra_20_2 (VECTOR_MODE.v:20) |
| ashr_792       | DW_rightsh     | A_width=13 | inst_GG4/sra_21 (VECTOR_MODE.v:21) |
         |                | SH_width=3 | inst_GG4/sra_21_2 (VECTOR_MODE.v:21) |
| ashr_794       | DW_rightsh     | A_width=13 | inst_GG3/sra_14 (VECTOR_MODE.v:14) |
         |                | SH_width=3 | inst_GG3/sra_14_2 (VECTOR_MODE.v:14) |
| ashr_795       | DW_rightsh     | A_width=13 | inst_GG3/sra_15 (VECTOR_MODE.v:15) |
         |                | SH_width=3 | inst_GG3/sra_15_2 (VECTOR_MODE.v:15) |
| ashr_796       | DW_rightsh     | A_width=13 | inst_GG3/sra_20 (VECTOR_MODE.v:20) |
         |                | SH_width=3 | inst_GG3/sra_20_2 (VECTOR_MODE.v:20) |
| ashr_797       | DW_rightsh     | A_width=13 | inst_GG3/sra_21 (VECTOR_MODE.v:21) |
         |                | SH_width=3 | inst_GG3/sra_21_2 (VECTOR_MODE.v:21) |
| ashr_799       | DW_rightsh     | A_width=13 | inst_GG2/sra_14 (VECTOR_MODE.v:14) |
         |                | SH_width=3 | inst_GG2/sra_14_2 (VECTOR_MODE.v:14) |
| ashr_800       | DW_rightsh     | A_width=13 | inst_GG2/sra_15 (VECTOR_MODE.v:15) |
         |                | SH_width=3 | inst_GG2/sra_15_2 (VECTOR_MODE.v:15) |
| ashr_801       | DW_rightsh     | A_width=13 | inst_GG2/sra_20 (VECTOR_MODE.v:20) |
         |                | SH_width=3 | inst_GG2/sra_20_2 (VECTOR_MODE.v:20) |
| ashr_802       | DW_rightsh     | A_width=13 | inst_GG2/sra_21 (VECTOR_MODE.v:21) |
         |                | SH_width=3 | inst_GG2/sra_21_2 (VECTOR_MODE.v:21) |
| sub_x_16       | DW01_dec       | width=3    | sub_139 (QR_CORDIC.v:139)  |
|                |                |            | sub_142 (QR_CORDIC.v:142)  |
| DP_OP_977_256_4402              |            |                            |
|                | DP_OP_977_256_4402 |        |                            |
| DP_OP_972_255_2361              |            |                            |
|                | DP_OP_972_255_2361 |        |                            |
| DP_OP_967_254_320               |            |                            |
|                | DP_OP_967_254_320 |         |                            |
| DP_OP_962_257_7395              |            |                            |
|                | DP_OP_962_257_7395 |        |                            |
| DP_OP_956_251_2599              |            |                            |
|                | DP_OP_956_251_2599 |        |                            |
| DP_OP_951_247_558               |            |                            |
|                | DP_OP_951_247_558 |         |                            |
| DP_OP_946_250_8484              |            |                            |
|                | DP_OP_946_250_8484 |        |                            |
| DP_OP_941_246_2837              |            |                            |
|                | DP_OP_941_246_2837 |        |                            |
| DP_OP_935_245_796               |            |                            |
|                | DP_OP_935_245_796 |         |                            |
| DP_OP_930_243_8722              |            |                            |
|                | DP_OP_930_243_8722 |        |                            |
| DP_OP_925_244_3753              |            |                            |
|                | DP_OP_925_244_3753 |        |                            |
| DP_OP_920_242_1712              |            |                            |
|                | DP_OP_920_242_1712 |        |                            |
| DP_OP_914J1_203_9638            |            |                            |
|                | DP_OP_914J1_203_9638 |      |                            |
| DP_OP_909J1_200_4640            |            |                            |
|                | DP_OP_909J1_200_4640 |      |                            |
| DP_OP_904J1_197_1950            |            |                            |
|                | DP_OP_904J1_197_1950 |      |                            |
| DP_OP_899J1_194_9876            |            |                            |
|                | DP_OP_899J1_194_9876 |      |                            |
| DP_OP_893J1_191_7835            |            |                            |
|                | DP_OP_893J1_191_7835 |      |                            |
| DP_OP_888J1_188_2188            |            |                            |
|                | DP_OP_888J1_188_2188 |      |                            |
| DP_OP_883J1_185_147             |            |                            |
|                | DP_OP_883J1_185_147 |       |                            |
| DP_OP_878J1_182_8073            |            |                            |
|                | DP_OP_878J1_182_8073 |      |                            |
| DP_OP_872J1_179_998             |            |                            |
|                | DP_OP_872J1_179_998 |       |                            |
| DP_OP_867J1_176_8924            |            |                            |
|                | DP_OP_867J1_176_8924 |      |                            |
| DP_OP_862J1_173_6883            |            |                            |
|                | DP_OP_862J1_173_6883 |      |                            |
| DP_OP_857J1_170_3991            |            |                            |
|                | DP_OP_857J1_170_3991 |      |                            |
| DP_OP_851J1_167_9162            |            |                            |
|                | DP_OP_851J1_167_9162 |      |                            |
| DP_OP_846J1_164_7121            |            |                            |
|                | DP_OP_846J1_164_7121 |      |                            |
| DP_OP_841J1_161_5080            |            |                            |
|                | DP_OP_841J1_161_5080 |      |                            |
| DP_OP_836J1_158_9400            |            |                            |
|                | DP_OP_836J1_158_9400 |      |                            |
| DP_OP_830J1_155_7359            |            |                            |
|                | DP_OP_830J1_155_7359 |      |                            |
| DP_OP_825J1_152_5318            |            |                            |
|                | DP_OP_825J1_152_5318 |      |                            |
| DP_OP_820J1_149_8210            |            |                            |
|                | DP_OP_820J1_149_8210 |      |                            |
| DP_OP_815J1_146_6169            |            |                            |
|                | DP_OP_815J1_146_6169 |      |                            |
| DP_OP_809J1_143_4128            |            |                            |
|                | DP_OP_809J1_143_4128 |      |                            |
| DP_OP_804J1_140_1236            |            |                            |
|                | DP_OP_804J1_140_1236 |      |                            |
| DP_OP_799J1_137_6407            |            |                            |
|                | DP_OP_799J1_137_6407 |      |                            |
| DP_OP_794J1_134_4366            |            |                            |
|                | DP_OP_794J1_134_4366 |      |                            |
| DP_OP_788_253_2325              |            |                            |
|                | DP_OP_788_253_2325 |        |                            |
| DP_OP_783_249_6645              |            |                            |
|                | DP_OP_783_249_6645 |        |                            |
| DP_OP_778_248_4604              |            |                            |
|                | DP_OP_778_248_4604 |        |                            |
| DP_OP_773_252_2563              |            |                            |
|                | DP_OP_773_252_2563 |        |                            |
=============================================================================

Datapath Report for DP_OP_977_256_4402
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_977_256_4402   | inst_GG2/sub_21 (VECTOR_MODE.v:21)                  |
|                      | inst_GG2/add_21 (VECTOR_MODE.v:21)                  |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (VECTOR_MODE.v:21)      |
==============================================================================

Datapath Report for DP_OP_972_255_2361
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_972_255_2361   | inst_GG2/add_20 (VECTOR_MODE.v:20)                  |
|                      | inst_GG2/sub_20 (VECTOR_MODE.v:20)                  |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (VECTOR_MODE.v:20)      |
==============================================================================

Datapath Report for DP_OP_967_254_320
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_967_254_320    | inst_GG2/sub_15 (VECTOR_MODE.v:15)                  |
|                      | inst_GG2/add_15 (VECTOR_MODE.v:15)                  |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (VECTOR_MODE.v:15)      |
==============================================================================

Datapath Report for DP_OP_962_257_7395
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_962_257_7395   | inst_GG2/add_14 (VECTOR_MODE.v:14)                  |
|                      | inst_GG2/sub_14 (VECTOR_MODE.v:14)                  |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (VECTOR_MODE.v:14)      |
==============================================================================

Datapath Report for DP_OP_956_251_2599
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_956_251_2599   | inst_GG3/sub_21 (VECTOR_MODE.v:21)                  |
|                      | inst_GG3/add_21 (VECTOR_MODE.v:21)                  |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (VECTOR_MODE.v:21)      |
==============================================================================

Datapath Report for DP_OP_951_247_558
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_951_247_558    | inst_GG3/add_20 (VECTOR_MODE.v:20)                  |
|                      | inst_GG3/sub_20 (VECTOR_MODE.v:20)                  |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (VECTOR_MODE.v:20)      |
==============================================================================

Datapath Report for DP_OP_946_250_8484
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_946_250_8484   | inst_GG3/sub_15 (VECTOR_MODE.v:15)                  |
|                      | inst_GG3/add_15 (VECTOR_MODE.v:15)                  |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (VECTOR_MODE.v:15)      |
==============================================================================

Datapath Report for DP_OP_941_246_2837
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_941_246_2837   | inst_GG3/add_14 (VECTOR_MODE.v:14)                  |
|                      | inst_GG3/sub_14 (VECTOR_MODE.v:14)                  |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (VECTOR_MODE.v:14)      |
==============================================================================

Datapath Report for DP_OP_935_245_796
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_935_245_796    | inst_GG4/sub_21 (VECTOR_MODE.v:21)                  |
|                      | inst_GG4/add_21 (VECTOR_MODE.v:21)                  |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (VECTOR_MODE.v:21)      |
==============================================================================

Datapath Report for DP_OP_930_243_8722
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_930_243_8722   | inst_GG4/add_20 (VECTOR_MODE.v:20)                  |
|                      | inst_GG4/sub_20 (VECTOR_MODE.v:20)                  |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (VECTOR_MODE.v:20)      |
==============================================================================

Datapath Report for DP_OP_925_244_3753
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_925_244_3753   | inst_GG4/sub_15 (VECTOR_MODE.v:15)                  |
|                      | inst_GG4/add_15 (VECTOR_MODE.v:15)                  |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (VECTOR_MODE.v:15)      |
==============================================================================

Datapath Report for DP_OP_920_242_1712
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_920_242_1712   | inst_GG4/add_14 (VECTOR_MODE.v:14)                  |
|                      | inst_GG4/sub_14 (VECTOR_MODE.v:14)                  |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (VECTOR_MODE.v:14)      |
==============================================================================

Datapath Report for DP_OP_914J1_203_9638
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_914J1_203_9638 | inst_GR2/sub_17 (ROTATION_MODE.v:17)                |
|                      | inst_GR2/add_17 (ROTATION_MODE.v:17)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:17)    |
==============================================================================

Datapath Report for DP_OP_909J1_200_4640
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_909J1_200_4640 | inst_GR2/add_16 (ROTATION_MODE.v:16)                |
|                      | inst_GR2/sub_16 (ROTATION_MODE.v:16)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:16)    |
==============================================================================

Datapath Report for DP_OP_904J1_197_1950
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_904J1_197_1950 | inst_GR2/sub_14 (ROTATION_MODE.v:14)                |
|                      | inst_GR2/add_14 (ROTATION_MODE.v:14)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:14)    |
==============================================================================

Datapath Report for DP_OP_899J1_194_9876
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_899J1_194_9876 | inst_GR2/add_13 (ROTATION_MODE.v:13)                |
|                      | inst_GR2/sub_13 (ROTATION_MODE.v:13)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:13)    |
==============================================================================

Datapath Report for DP_OP_893J1_191_7835
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_893J1_191_7835 | inst_GR3/sub_17 (ROTATION_MODE.v:17)                |
|                      | inst_GR3/add_17 (ROTATION_MODE.v:17)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:17)    |
==============================================================================

Datapath Report for DP_OP_888J1_188_2188
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_888J1_188_2188 | inst_GR3/add_16 (ROTATION_MODE.v:16)                |
|                      | inst_GR3/sub_16 (ROTATION_MODE.v:16)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:16)    |
==============================================================================

Datapath Report for DP_OP_883J1_185_147
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_883J1_185_147  | inst_GR3/sub_14 (ROTATION_MODE.v:14)                |
|                      | inst_GR3/add_14 (ROTATION_MODE.v:14)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:14)    |
==============================================================================

Datapath Report for DP_OP_878J1_182_8073
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_878J1_182_8073 | inst_GR3/add_13 (ROTATION_MODE.v:13)                |
|                      | inst_GR3/sub_13 (ROTATION_MODE.v:13)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:13)    |
==============================================================================

Datapath Report for DP_OP_872J1_179_998
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_872J1_179_998  | inst_GR4/sub_17 (ROTATION_MODE.v:17)                |
|                      | inst_GR4/add_17 (ROTATION_MODE.v:17)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:17)    |
==============================================================================

Datapath Report for DP_OP_867J1_176_8924
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_867J1_176_8924 | inst_GR4/add_16 (ROTATION_MODE.v:16)                |
|                      | inst_GR4/sub_16 (ROTATION_MODE.v:16)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:16)    |
==============================================================================

Datapath Report for DP_OP_862J1_173_6883
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_862J1_173_6883 | inst_GR4/sub_14 (ROTATION_MODE.v:14)                |
|                      | inst_GR4/add_14 (ROTATION_MODE.v:14)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:14)    |
==============================================================================

Datapath Report for DP_OP_857J1_170_3991
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_857J1_170_3991 | inst_GR4/add_13 (ROTATION_MODE.v:13)                |
|                      | inst_GR4/sub_13 (ROTATION_MODE.v:13)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:13)    |
==============================================================================

Datapath Report for DP_OP_851J1_167_9162
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_851J1_167_9162 | inst_GR5/sub_17 (ROTATION_MODE.v:17)                |
|                      | inst_GR5/add_17 (ROTATION_MODE.v:17)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:17)    |
==============================================================================

Datapath Report for DP_OP_846J1_164_7121
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_846J1_164_7121 | inst_GR5/add_16 (ROTATION_MODE.v:16)                |
|                      | inst_GR5/sub_16 (ROTATION_MODE.v:16)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:16)    |
==============================================================================

Datapath Report for DP_OP_841J1_161_5080
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_841J1_161_5080 | inst_GR5/sub_14 (ROTATION_MODE.v:14)                |
|                      | inst_GR5/add_14 (ROTATION_MODE.v:14)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:14)    |
==============================================================================

Datapath Report for DP_OP_836J1_158_9400
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_836J1_158_9400 | inst_GR5/add_13 (ROTATION_MODE.v:13)                |
|                      | inst_GR5/sub_13 (ROTATION_MODE.v:13)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:13)    |
==============================================================================

Datapath Report for DP_OP_830J1_155_7359
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_830J1_155_7359 | inst_GR6/sub_17 (ROTATION_MODE.v:17)                |
|                      | inst_GR6/add_17 (ROTATION_MODE.v:17)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:17)    |
==============================================================================

Datapath Report for DP_OP_825J1_152_5318
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_825J1_152_5318 | inst_GR6/add_16 (ROTATION_MODE.v:16)                |
|                      | inst_GR6/sub_16 (ROTATION_MODE.v:16)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:16)    |
==============================================================================

Datapath Report for DP_OP_820J1_149_8210
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_820J1_149_8210 | inst_GR6/sub_14 (ROTATION_MODE.v:14)                |
|                      | inst_GR6/add_14 (ROTATION_MODE.v:14)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:14)    |
==============================================================================

Datapath Report for DP_OP_815J1_146_6169
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_815J1_146_6169 | inst_GR6/add_13 (ROTATION_MODE.v:13)                |
|                      | inst_GR6/sub_13 (ROTATION_MODE.v:13)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:13)    |
==============================================================================

Datapath Report for DP_OP_809J1_143_4128
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_809J1_143_4128 | inst_GR1/sub_17 (ROTATION_MODE.v:17)                |
|                      | inst_GR1/add_17 (ROTATION_MODE.v:17)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:17)    |
==============================================================================

Datapath Report for DP_OP_804J1_140_1236
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_804J1_140_1236 | inst_GR1/add_16 (ROTATION_MODE.v:16)                |
|                      | inst_GR1/sub_16 (ROTATION_MODE.v:16)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:16)    |
==============================================================================

Datapath Report for DP_OP_799J1_137_6407
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_799J1_137_6407 | inst_GR1/sub_14 (ROTATION_MODE.v:14)                |
|                      | inst_GR1/add_14 (ROTATION_MODE.v:14)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:14)    |
==============================================================================

Datapath Report for DP_OP_794J1_134_4366
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_794J1_134_4366 | inst_GR1/add_13 (ROTATION_MODE.v:13)                |
|                      | inst_GR1/sub_13 (ROTATION_MODE.v:13)                |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (ROTATION_MODE.v:13)    |
==============================================================================

Datapath Report for DP_OP_788_253_2325
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_788_253_2325   | inst_GG1/sub_21 (VECTOR_MODE.v:21)                  |
|                      | inst_GG1/add_21 (VECTOR_MODE.v:21)                  |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (VECTOR_MODE.v:21)      |
==============================================================================

Datapath Report for DP_OP_783_249_6645
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_783_249_6645   | inst_GG1/add_20 (VECTOR_MODE.v:20)                  |
|                      | inst_GG1/sub_20 (VECTOR_MODE.v:20)                  |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (VECTOR_MODE.v:20)      |
==============================================================================

Datapath Report for DP_OP_778_248_4604
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_778_248_4604   | inst_GG1/sub_15 (VECTOR_MODE.v:15)                  |
|                      | inst_GG1/add_15 (VECTOR_MODE.v:15)                  |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (VECTOR_MODE.v:15)      |
==============================================================================

Datapath Report for DP_OP_773_252_2563
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_773_252_2563   | inst_GG1/add_14 (VECTOR_MODE.v:14)                  |
|                      | inst_GG1/sub_14 (VECTOR_MODE.v:14)                  |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 13    |                                          |
| I2    | PI   | Signed   | 13    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 13    | addsub(I1,I2,I3) (VECTOR_MODE.v:14)      |
==============================================================================


Implementation Report
===============================================================================
|                    |                  | Current            | Set            |
| Cell               | Module           | Implementation     | Implementation |
===============================================================================
| mult_x_1           | DW_mult_tc       | apparch (area)     |                |
| mult_x_2           | DW_mult_tc       | apparch (area)     |                |
| mult_x_3           | DW_mult_tc       | apparch (area)     |                |
| mult_x_4           | DW_mult_tc       | apparch (area)     |                |
| sub_x_5            | DW01_dec         | apparch (area)     |                |
| sub_x_6            | DW01_dec         | apparch (area)     |                |
| sub_x_7            | DW01_dec         | apparch (area)     |                |
| sub_x_8            | DW01_dec         | apparch (area)     |                |
| add_x_9            | DW01_add         | apparch (area)     |                |
| add_x_10           | DW01_add         | apparch (area)     |                |
| add_x_11           | DW01_add         | apparch (area)     |                |
| add_x_12           | DW01_add         | apparch (area)     |                |
| add_x_753          | DW01_inc         | apparch (area)     |                |
| add_x_758          | DW01_inc         | apparch (area)     |                |
| add_x_763          | DW01_inc         | apparch (area)     |                |
| add_x_768          | DW01_inc         | apparch (area)     |                |
| add_x_773          | DW01_inc         | apparch (area)     |                |
| add_x_778          | DW01_inc         | apparch (area)     |                |
| add_x_783          | DW01_inc         | apparch (area)     |                |
| add_x_788          | DW01_inc         | apparch (area)     |                |
| add_x_793          | DW01_inc         | apparch (area)     |                |
| add_x_798          | DW01_inc         | apparch (area)     |                |
| ashr_754           | DW_rightsh       | astr (area)        |                |
| ashr_755           | DW_rightsh       | astr (area)        |                |
| ashr_756           | DW_rightsh       | astr (area)        |                |
| ashr_757           | DW_rightsh       | astr (area)        |                |
| ashr_759           | DW_rightsh       | astr (area)        |                |
| ashr_760           | DW_rightsh       | astr (area)        |                |
| ashr_761           | DW_rightsh       | astr (area)        |                |
| ashr_762           | DW_rightsh       | astr (area)        |                |
| ashr_764           | DW_rightsh       | astr (area)        |                |
| ashr_765           | DW_rightsh       | astr (area)        |                |
| ashr_766           | DW_rightsh       | astr (area)        |                |
| ashr_767           | DW_rightsh       | astr (area)        |                |
| ashr_769           | DW_rightsh       | astr (area)        |                |
| ashr_770           | DW_rightsh       | astr (area)        |                |
| ashr_771           | DW_rightsh       | astr (area)        |                |
| ashr_772           | DW_rightsh       | astr (area)        |                |
| ashr_774           | DW_rightsh       | astr (area)        |                |
| ashr_775           | DW_rightsh       | astr (area)        |                |
| ashr_776           | DW_rightsh       | astr (area)        |                |
| ashr_777           | DW_rightsh       | astr (area)        |                |
| ashr_779           | DW_rightsh       | astr (area)        |                |
| ashr_780           | DW_rightsh       | astr (area)        |                |
| ashr_781           | DW_rightsh       | astr (area)        |                |
| ashr_782           | DW_rightsh       | astr (area)        |                |
| ashr_784           | DW_rightsh       | astr (area)        |                |
| ashr_785           | DW_rightsh       | astr (area)        |                |
| ashr_786           | DW_rightsh       | astr (area)        |                |
| ashr_787           | DW_rightsh       | astr (area)        |                |
| ashr_789           | DW_rightsh       | astr (area)        |                |
| ashr_790           | DW_rightsh       | astr (area)        |                |
| ashr_791           | DW_rightsh       | astr (area)        |                |
| ashr_792           | DW_rightsh       | astr (area)        |                |
| ashr_794           | DW_rightsh       | astr (area)        |                |
| ashr_795           | DW_rightsh       | astr (area)        |                |
| ashr_796           | DW_rightsh       | astr (area)        |                |
| ashr_797           | DW_rightsh       | astr (area)        |                |
| ashr_799           | DW_rightsh       | astr (area)        |                |
| ashr_800           | DW_rightsh       | astr (area)        |                |
| ashr_801           | DW_rightsh       | astr (area)        |                |
| ashr_802           | DW_rightsh       | astr (area)        |                |
| sub_x_16           | DW01_dec         | apparch (area)     |                |
| DP_OP_977_256_4402 | DP_OP_977_256_4402 | str (area)       |                |
| DP_OP_972_255_2361 | DP_OP_972_255_2361 | str (area)       |                |
| DP_OP_967_254_320  | DP_OP_967_254_320 | str (area)        |                |
| DP_OP_962_257_7395 | DP_OP_962_257_7395 | str (area)       |                |
| DP_OP_956_251_2599 | DP_OP_956_251_2599 | str (area)       |                |
| DP_OP_951_247_558  | DP_OP_951_247_558 | str (area)        |                |
| DP_OP_946_250_8484 | DP_OP_946_250_8484 | str (area,speed) |                |
| DP_OP_941_246_2837 | DP_OP_941_246_2837 | str (area,speed) |                |
| DP_OP_935_245_796  | DP_OP_935_245_796 | str (area)        |                |
| DP_OP_930_243_8722 | DP_OP_930_243_8722 | str (area)       |                |
| DP_OP_925_244_3753 | DP_OP_925_244_3753 | str (area,speed) |                |
| DP_OP_920_242_1712 | DP_OP_920_242_1712 | str (area,speed) |                |
| DP_OP_914J1_203_9638                  |                    |                |
|                    | DP_OP_914J1_203_9638 | str (area)     |                |
| DP_OP_909J1_200_4640                  |                    |                |
|                    | DP_OP_909J1_200_4640 | str (area)     |                |
| DP_OP_904J1_197_1950                  |                    |                |
|                    | DP_OP_904J1_197_1950 | str (area)     |                |
| DP_OP_899J1_194_9876                  |                    |                |
|                    | DP_OP_899J1_194_9876 | str (area)     |                |
| DP_OP_893J1_191_7835                  |                    |                |
|                    | DP_OP_893J1_191_7835 | str (area,speed)                |
| DP_OP_888J1_188_2188                  |                    |                |
|                    | DP_OP_888J1_188_2188 | str (area,speed)                |
| DP_OP_883J1_185_147                   |                    |                |
|                    | DP_OP_883J1_185_147 | str (area)      |                |
| DP_OP_878J1_182_8073                  |                    |                |
|                    | DP_OP_878J1_182_8073 | str (area)     |                |
| DP_OP_872J1_179_998                   |                    |                |
|                    | DP_OP_872J1_179_998 | str (area)      |                |
| DP_OP_867J1_176_8924                  |                    |                |
|                    | DP_OP_867J1_176_8924 | str (area)     |                |
| DP_OP_862J1_173_6883                  |                    |                |
|                    | DP_OP_862J1_173_6883 | str (area)     |                |
| DP_OP_857J1_170_3991                  |                    |                |
|                    | DP_OP_857J1_170_3991 | str (area)     |                |
| DP_OP_851J1_167_9162                  |                    |                |
|                    | DP_OP_851J1_167_9162 | str (area)     |                |
| DP_OP_846J1_164_7121                  |                    |                |
|                    | DP_OP_846J1_164_7121 | str (area,speed)                |
| DP_OP_841J1_161_5080                  |                    |                |
|                    | DP_OP_841J1_161_5080 | str (area)     |                |
| DP_OP_836J1_158_9400                  |                    |                |
|                    | DP_OP_836J1_158_9400 | str (area)     |                |
| DP_OP_830J1_155_7359                  |                    |                |
|                    | DP_OP_830J1_155_7359 | str (area)     |                |
| DP_OP_825J1_152_5318                  |                    |                |
|                    | DP_OP_825J1_152_5318 | str (area,speed)                |
| DP_OP_820J1_149_8210                  |                    |                |
|                    | DP_OP_820J1_149_8210 | str (area)     |                |
| DP_OP_815J1_146_6169                  |                    |                |
|                    | DP_OP_815J1_146_6169 | str (area,speed)                |
| DP_OP_809J1_143_4128                  |                    |                |
|                    | DP_OP_809J1_143_4128 | str (area)     |                |
| DP_OP_804J1_140_1236                  |                    |                |
|                    | DP_OP_804J1_140_1236 | str (area)     |                |
| DP_OP_799J1_137_6407                  |                    |                |
|                    | DP_OP_799J1_137_6407 | str (area)     |                |
| DP_OP_794J1_134_4366                  |                    |                |
|                    | DP_OP_794J1_134_4366 | str (area)     |                |
| DP_OP_788_253_2325 | DP_OP_788_253_2325 | str (area)       |                |
| DP_OP_783_249_6645 | DP_OP_783_249_6645 | str (area)       |                |
| DP_OP_778_248_4604 | DP_OP_778_248_4604 | str (area,speed) |                |
| DP_OP_773_252_2563 | DP_OP_773_252_2563 | str (area,speed) |                |
===============================================================================

1
