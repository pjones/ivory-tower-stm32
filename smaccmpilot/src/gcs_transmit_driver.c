/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.0
 */
#include "gcs_transmit_driver.h"
void gcs_transmit_send_heartbeat(struct motorsoutput_result* n_var0,
                                 struct userinput_result* n_var1,
                                 struct smavlink_out_channel* n_var2,
                                 struct smavlink_system* n_var3)
{
    struct heartbeat_msg n_local0 = {};
    struct heartbeat_msg* n_ref1 = &n_local0;
    bool n_deref2 = *&n_var0->armed;
    uint8_t n_deref3 = *&n_var1->mode;
    
    *&n_ref1->custom_mode = n_deref3 == 0U ? 0U : n_deref3 ==
        1U ? 2U : n_deref3 == 2U ? 5U : 0U;
    *&n_ref1->mavtype = 2U;
    *&n_ref1->autopilot = 3U;
    if (n_deref2) {
        *&n_ref1->base_mode = 128U;
    } else {
        *&n_ref1->base_mode = 1U;
    }
    *&n_ref1->mavlink_version = 3U;
    smavlink_send_heartbeat(n_ref1, n_var2, n_var3);
    return;
}
void gcs_transmit_send_attitude(struct sensors_result* n_var0,
                                struct smavlink_out_channel* n_var1,
                                struct smavlink_system* n_var2)
{
    struct attitude_msg n_local0 = {};
    struct attitude_msg* n_ref1 = &n_local0;
    uint32_t n_deref2 = *&n_var0->time;
    
    *&n_ref1->time_boot_ms = n_deref2;
    
    float n_deref3 = *&n_var0->roll;
    
    *&n_ref1->roll = n_deref3;
    
    float n_deref4 = *&n_var0->pitch;
    
    *&n_ref1->pitch = n_deref4;
    
    float n_deref5 = *&n_var0->yaw;
    
    *&n_ref1->yaw = n_deref5;
    
    float n_deref6 = *&n_var0->omega_x;
    
    *&n_ref1->rollspeed = n_deref6;
    
    float n_deref7 = *&n_var0->omega_y;
    
    *&n_ref1->rollspeed = n_deref7;
    
    float n_deref8 = *&n_var0->omega_z;
    
    *&n_ref1->rollspeed = n_deref8;
    smavlink_send_attitude(n_ref1, n_var1, n_var2);
    return;
}
void gcs_transmit_send_vfrhud(struct position_result* n_var0,
                              struct motorsoutput_result* n_var1,
                              struct sensors_result* n_var2,
                              struct smavlink_out_channel* n_var3,
                              struct smavlink_system* n_var4)
{
    struct vfr_hud_msg n_local0 = {};
    struct vfr_hud_msg* n_ref1 = &n_local0;
    int16_t n_deref2 = *&n_var0->vx;
    int16_t n_deref3 = *&n_var0->vy;
    int16_t n_deref4 = *&n_var0->vz;
    
    ASSERTS(n_deref2 * n_deref2 + n_deref3 * n_deref3 > 0 && (n_deref4 *
                                                              n_deref4 > 0 &&
                                                              127 - (n_deref2 *
                                                                     n_deref2 +
                                                                     n_deref3 *
                                                                     n_deref3) >=
                                                              n_deref4 *
                                                              n_deref4) ||
        (n_deref2 * n_deref2 + n_deref3 * n_deref3 >= 0 && n_deref4 *
         n_deref4 <= 0 || (n_deref2 * n_deref2 + n_deref3 * n_deref3 <= 0 &&
                           n_deref4 * n_deref4 >= 0 || n_deref2 * n_deref2 +
                           n_deref3 * n_deref3 < 0 && (n_deref4 * n_deref4 <
                                                       0 && -128 - (n_deref2 *
                                                                    n_deref2 +
                                                                    n_deref3 *
                                                                    n_deref3) <=
                                                       n_deref4 * n_deref4))));
    ASSERTS(n_deref2 * n_deref2 > 0 && (n_deref3 * n_deref3 > 0 && 127 -
                                        n_deref2 * n_deref2 >= n_deref3 *
                                        n_deref3) || (n_deref2 * n_deref2 >=
                                                      0 && n_deref3 *
                                                      n_deref3 <= 0 ||
                                                      (n_deref2 * n_deref2 <=
                                                       0 && n_deref3 *
                                                       n_deref3 >= 0 ||
                                                       n_deref2 * n_deref2 <
                                                       0 && (n_deref3 *
                                                             n_deref3 < 0 &&
                                                             -128 - n_deref2 *
                                                             n_deref2 <=
                                                             n_deref3 *
                                                             n_deref3))));
    ASSERTS(n_deref2 >= 0 && (n_deref2 >= 0 && (n_deref2 == 0 || 127 /
                                                n_deref2 >= n_deref2)) ||
        (n_deref2 < 0 && (n_deref2 < 0 && (n_deref2 == 0 || 127 / n_deref2 >=
                                           n_deref2)) || (n_deref2 < 0 &&
                                                          (n_deref2 > 0 &&
                                                           n_deref2 <= -128 /
                                                           n_deref2) ||
                                                          n_deref2 > 0 &&
                                                          (n_deref2 < 0 &&
                                                           n_deref2 <= -128 /
                                                           n_deref2))));
    ASSERTS(n_deref3 >= 0 && (n_deref3 >= 0 && (n_deref3 == 0 || 127 /
                                                n_deref3 >= n_deref3)) ||
        (n_deref3 < 0 && (n_deref3 < 0 && (n_deref3 == 0 || 127 / n_deref3 >=
                                           n_deref3)) || (n_deref3 < 0 &&
                                                          (n_deref3 > 0 &&
                                                           n_deref3 <= -128 /
                                                           n_deref3) ||
                                                          n_deref3 > 0 &&
                                                          (n_deref3 < 0 &&
                                                           n_deref3 <= -128 /
                                                           n_deref3))));
    ASSERTS(n_deref4 >= 0 && (n_deref4 >= 0 && (n_deref4 == 0 || 127 /
                                                n_deref4 >= n_deref4)) ||
        (n_deref4 < 0 && (n_deref4 < 0 && (n_deref4 == 0 || 127 / n_deref4 >=
                                           n_deref4)) || (n_deref4 < 0 &&
                                                          (n_deref4 > 0 &&
                                                           n_deref4 <= -128 /
                                                           n_deref4) ||
                                                          n_deref4 > 0 &&
                                                          (n_deref4 < 0 &&
                                                           n_deref4 <= -128 /
                                                           n_deref4))));
    
    float n_let5 = (float) (n_deref2 * n_deref2 + n_deref3 * n_deref3 +
                            n_deref4 * n_deref4);
    
    *&n_ref1->groundspeed = sqrtf(n_let5);
    
    int16_t n_deref6 = *&n_var0->vx;
    int16_t n_deref7 = *&n_var0->vy;
    int16_t n_deref8 = *&n_var0->vz;
    
    ASSERTS(n_deref6 * n_deref6 + n_deref7 * n_deref7 > 0 && (n_deref8 *
                                                              n_deref8 > 0 &&
                                                              127 - (n_deref6 *
                                                                     n_deref6 +
                                                                     n_deref7 *
                                                                     n_deref7) >=
                                                              n_deref8 *
                                                              n_deref8) ||
        (n_deref6 * n_deref6 + n_deref7 * n_deref7 >= 0 && n_deref8 *
         n_deref8 <= 0 || (n_deref6 * n_deref6 + n_deref7 * n_deref7 <= 0 &&
                           n_deref8 * n_deref8 >= 0 || n_deref6 * n_deref6 +
                           n_deref7 * n_deref7 < 0 && (n_deref8 * n_deref8 <
                                                       0 && -128 - (n_deref6 *
                                                                    n_deref6 +
                                                                    n_deref7 *
                                                                    n_deref7) <=
                                                       n_deref8 * n_deref8))));
    ASSERTS(n_deref6 * n_deref6 > 0 && (n_deref7 * n_deref7 > 0 && 127 -
                                        n_deref6 * n_deref6 >= n_deref7 *
                                        n_deref7) || (n_deref6 * n_deref6 >=
                                                      0 && n_deref7 *
                                                      n_deref7 <= 0 ||
                                                      (n_deref6 * n_deref6 <=
                                                       0 && n_deref7 *
                                                       n_deref7 >= 0 ||
                                                       n_deref6 * n_deref6 <
                                                       0 && (n_deref7 *
                                                             n_deref7 < 0 &&
                                                             -128 - n_deref6 *
                                                             n_deref6 <=
                                                             n_deref7 *
                                                             n_deref7))));
    ASSERTS(n_deref6 >= 0 && (n_deref6 >= 0 && (n_deref6 == 0 || 127 /
                                                n_deref6 >= n_deref6)) ||
        (n_deref6 < 0 && (n_deref6 < 0 && (n_deref6 == 0 || 127 / n_deref6 >=
                                           n_deref6)) || (n_deref6 < 0 &&
                                                          (n_deref6 > 0 &&
                                                           n_deref6 <= -128 /
                                                           n_deref6) ||
                                                          n_deref6 > 0 &&
                                                          (n_deref6 < 0 &&
                                                           n_deref6 <= -128 /
                                                           n_deref6))));
    ASSERTS(n_deref7 >= 0 && (n_deref7 >= 0 && (n_deref7 == 0 || 127 /
                                                n_deref7 >= n_deref7)) ||
        (n_deref7 < 0 && (n_deref7 < 0 && (n_deref7 == 0 || 127 / n_deref7 >=
                                           n_deref7)) || (n_deref7 < 0 &&
                                                          (n_deref7 > 0 &&
                                                           n_deref7 <= -128 /
                                                           n_deref7) ||
                                                          n_deref7 > 0 &&
                                                          (n_deref7 < 0 &&
                                                           n_deref7 <= -128 /
                                                           n_deref7))));
    ASSERTS(n_deref8 >= 0 && (n_deref8 >= 0 && (n_deref8 == 0 || 127 /
                                                n_deref8 >= n_deref8)) ||
        (n_deref8 < 0 && (n_deref8 < 0 && (n_deref8 == 0 || 127 / n_deref8 >=
                                           n_deref8)) || (n_deref8 < 0 &&
                                                          (n_deref8 > 0 &&
                                                           n_deref8 <= -128 /
                                                           n_deref8) ||
                                                          n_deref8 > 0 &&
                                                          (n_deref8 < 0 &&
                                                           n_deref8 <= -128 /
                                                           n_deref8))));
    
    float n_let9 = (float) (n_deref6 * n_deref6 + n_deref7 * n_deref7 +
                            n_deref8 * n_deref8);
    
    *&n_ref1->airspeed = sqrtf(n_let9);
    
    int32_t n_deref10 = *&n_var0->gps_alt;
    float n_let11 = (float) n_deref10;
    
    *&n_ref1->alt = n_let11 / 1000.0f;
    
    int16_t n_deref12 = *&n_var0->vz;
    
    *&n_ref1->climb = (float) n_deref12;
    
    float n_deref13 = *&n_var2->yaw;
    float n_let14 = 180.0f / 3.1415927f * n_deref13;
    int16_t n_let15 = (bool) isnan(n_let14) ? 0 : (int16_t) truncf(n_let14);
    
    *&n_ref1->heading = n_let15;
    
    float n_deref16 = *&n_var1->throttle;
    
    ASSERTS(n_deref16 == 0U || 65535U / n_deref16 >= 100.0f);
    ASSERTS(n_deref16 == 0U || 65535U / n_deref16 >= 100.0f);
    *&n_ref1->throttle = (bool) isnan(n_deref16 *
        100.0f) ? 0U : (uint16_t) truncf(n_deref16 * 100.0f);
    smavlink_send_vfr_hud(n_ref1, n_var3, n_var4);
    return;
}
void gcs_transmit_send_servo_output(struct servo_result* n_var0,
                                    struct userinput_result* n_var1,
                                    struct smavlink_out_channel* n_var2,
                                    struct smavlink_system* n_var3)
{
    struct servo_output_raw_msg n_local0 = {};
    struct servo_output_raw_msg* n_ref1 = &n_local0;
    uint32_t n_deref2 = *&n_var0->time;
    
    *&n_ref1->time_usec = n_deref2;
    
    uint16_t n_deref3 = *&n_var0->servo1;
    
    *&n_ref1->servo1_raw = n_deref3;
    
    uint16_t n_deref4 = *&n_var0->servo2;
    
    *&n_ref1->servo2_raw = n_deref4;
    
    uint16_t n_deref5 = *&n_var0->servo3;
    
    *&n_ref1->servo3_raw = n_deref5;
    
    uint16_t n_deref6 = *&n_var0->servo4;
    
    *&n_ref1->servo4_raw = n_deref6;
    
    float n_deref7 = *&n_var1->pitch;
    float n_deref8 = *&n_var1->roll;
    float n_deref9 = *&n_var1->throttle;
    
    ASSERTS(n_deref8 + 1.0f == 0U || 65535U / (n_deref8 + 1.0f) >= 100.0f);
    ASSERTS(65535U - n_deref8 >= 1.0f);
    ASSERTS(n_deref8 + 1.0f == 0U || 65535U / (n_deref8 + 1.0f) >= 100.0f);
    ASSERTS(65535U - n_deref8 >= 1.0f);
    *&n_ref1->servo6_raw = (bool) isnan((n_deref8 + 1.0f) *
        100.0f) ? 9999U : (uint16_t) truncf((n_deref8 + 1.0f) * 100.0f);
    ASSERTS(n_deref7 + 1.0f == 0U || 65535U / (n_deref7 + 1.0f) >= 100.0f);
    ASSERTS(65535U - n_deref7 >= 1.0f);
    ASSERTS(n_deref7 + 1.0f == 0U || 65535U / (n_deref7 + 1.0f) >= 100.0f);
    ASSERTS(65535U - n_deref7 >= 1.0f);
    *&n_ref1->servo7_raw = (bool) isnan((n_deref7 + 1.0f) *
        100.0f) ? 9999U : (uint16_t) truncf((n_deref7 + 1.0f) * 100.0f);
    ASSERTS(n_deref9 + 1.0f == 0U || 65535U / (n_deref9 + 1.0f) >= 100.0f);
    ASSERTS(65535U - n_deref9 >= 1.0f);
    ASSERTS(n_deref9 + 1.0f == 0U || 65535U / (n_deref9 + 1.0f) >= 100.0f);
    ASSERTS(65535U - n_deref9 >= 1.0f);
    *&n_ref1->servo8_raw = (bool) isnan((n_deref9 + 1.0f) *
        100.0f) ? 9999U : (uint16_t) truncf((n_deref9 + 1.0f) * 100.0f);
    smavlink_send_servo_output_raw(n_ref1, n_var2, n_var3);
}
void gcs_transmit_send_gps_raw_int(struct position_result* n_var0,
                                   struct smavlink_out_channel* n_var1,
                                   struct smavlink_system* n_var2)
{
    struct gps_raw_int_msg n_local0 = {};
    struct gps_raw_int_msg* n_ref1 = &n_local0;
    int32_t n_deref2 = *&n_var0->lat;
    
    *&n_ref1->lat = n_deref2;
    
    int32_t n_deref3 = *&n_var0->lon;
    
    *&n_ref1->lon = n_deref3;
    
    int32_t n_deref4 = *&n_var0->gps_alt;
    
    *&n_ref1->alt = n_deref4;
    *&n_ref1->eph = 10U;
    *&n_ref1->epv = 10U;
    *&n_ref1->vel = 1U;
    *&n_ref1->cog = 359U;
    *&n_ref1->fix_type = 3U;
    *&n_ref1->satellites_visible = 8U;
    smavlink_send_gps_raw_int(n_ref1, n_var1, n_var2);
    return;
}
void gcs_transmit_send_global_position_int(struct position_result* n_var0,
                                           struct sensors_result* n_var1,
                                           struct smavlink_out_channel* n_var2,
                                           struct smavlink_system* n_var3)
{
    struct global_position_int_msg n_local0 = {};
    struct global_position_int_msg* n_ref1 = &n_local0;
    float n_deref2 = *&n_var1->yaw;
    float n_let3 = 1800.0f / 3.1415927f * n_deref2;
    
    *&n_ref1->hdg = (bool) isnan(n_let3) ? 9999U : (uint16_t) truncf(n_let3);
    
    int32_t n_deref4 = *&n_var0->lat;
    
    *&n_ref1->lat = n_deref4;
    
    int32_t n_deref5 = *&n_var0->lon;
    
    *&n_ref1->lon = n_deref5;
    
    int32_t n_deref6 = *&n_var0->gps_alt;
    
    *&n_ref1->alt = n_deref6;
    
    int16_t n_deref7 = *&n_var0->vx;
    
    *&n_ref1->vx = n_deref7;
    
    int16_t n_deref8 = *&n_var0->vy;
    
    *&n_ref1->vy = n_deref8;
    
    int16_t n_deref9 = *&n_var0->vz;
    
    *&n_ref1->vz = n_deref9;
    smavlink_send_global_position_int(n_ref1, n_var2, n_var3);
    return;
}
void gcs_transmit_send_param_value(struct param_info* n_var0,
                                   struct smavlink_out_channel* n_var1,
                                   struct smavlink_system* n_var2)
{
    struct param_value_msg n_local0 = {};
    struct param_value_msg* n_ref1 = &n_local0;
    float n_r2 = param_get_float_value(n_var0);
    
    *&n_ref1->param_value = n_r2;
    
    int32_t* n_ref3 = &g_param_count;
    int32_t n_deref4 = *n_ref3;
    
    *&n_ref1->param_count = (uint16_t) n_deref4;
    
    int32_t n_deref5 = *&n_var0->param_index;
    
    *&n_ref1->param_index = (uint16_t) n_deref5;
    strncpy((uint8_t*) n_ref1->param_id, (const char*) n_var0->param_name, 16U);
    *&n_ref1->param_type = 0U;
    smavlink_send_param_value(n_ref1, n_var1, n_var2);
}
void gcs_transmit_send_params(struct smavlink_out_channel* n_var0,
                              struct smavlink_system* n_var1)
{
    struct param_info* n_r0 = param_get_requested();
    
    if (NULL != n_r0) {
        *&n_r0->param_requested = 0U;
        gcs_transmit_send_param_value(n_r0, n_var0, n_var1);
    } else {
        return;
    }
}
