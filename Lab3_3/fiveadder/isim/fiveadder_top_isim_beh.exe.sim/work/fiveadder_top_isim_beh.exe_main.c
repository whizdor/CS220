/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_16699208804701929196_2902715030_init();
    work_m_13567971792205582524_1698222184_init();
    work_m_13745692200583197745_0898501645_init();
    work_m_01165253182320212871_1485883089_init();
    work_m_18159756949521923683_1656118458_init();
    work_m_04084090712956072789_3020276698_init();
    work_m_16541823861846354283_2073120511_init();


    xsi_register_tops("work_m_04084090712956072789_3020276698");
    xsi_register_tops("work_m_16541823861846354283_2073120511");


    return xsi_run_simulation(argc, argv);

}
