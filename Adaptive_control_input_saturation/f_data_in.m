function [t, y, u, ud, wd, ref] = f_data_in(yout, uout, udout, wdout, refout)
t = yout.Time;
y = yout.Data;
u = uout.Data;
ud = udout.Data;
wd = wdout.Data;
ref = refout.Data;