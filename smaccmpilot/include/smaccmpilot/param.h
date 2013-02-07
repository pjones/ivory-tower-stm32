/* This file has been autogenerated by Ivory
 * Compiler version  0.1.0.0
 */
#ifndef __PARAM_H__
#define __PARAM_H__
#ifdef __cplusplus
extern "C" {
#endif
#include <ivory.h>
#include "ivory_string.h"
struct param_info {
    uint8_t param_type;
    char param_name[32U];
    uint16_t param_index;
    uint8_t* param_ptr_u8;
    uint16_t* param_ptr_u16;
    uint32_t* param_ptr_u32;
    float* param_ptr_float;
};
struct param_info* param_new();
void param_init_u8(char* n_var0, uint8_t* n_var1);
void param_init_u16(char* n_var0, uint16_t* n_var1);
void param_init_u32(char* n_var0, uint32_t* n_var1);
void param_init_float(char* n_var0, float* n_var1);
struct param_info* param_get_by_name(const char* n_var0);
struct param_info* param_get_by_index(uint16_t n_var0);
float param_get_float_value(struct param_info* n_var0);
extern struct param_info g_param_info[512U];
extern uint16_t g_param_count;

#ifdef __cplusplus
}
#endif
#endif /* __PARAM_H__ */