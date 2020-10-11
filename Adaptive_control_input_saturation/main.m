disp('------------------------------* MRAC-Hinf and MARC-LQR  *------------------------------')

disp('------------------------------* MRAC control  *------------------------------')

g_MRAC_design_Hinf;
sim('MARC_Hinf_Input_Saturation.slx');
[t, y, u, ud, wd, ref] = f_data_in(yout, uout, udout, wdout, refout);

g_plot_results;
