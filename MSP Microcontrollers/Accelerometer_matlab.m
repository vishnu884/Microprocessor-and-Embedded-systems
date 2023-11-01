clear device
%%%%check the COM number. If you are using other ports please modify the
%%%%following code
device = serialport("COM6",9600);

figure;
%%%%loops for 1000 times
for i = 1:1000
    str_arr = split(readline(device));
    x = str2double(str_arr(1));
    y = str2double(str_arr(2));
    z = str2double(str_arr(3));
    plot3(x,y,z,'o');

    %%%%change the following code to make sure your acceleration values do
    %%%%not overflow in each directions. (The default limit is from 1 to 1024)
    xlim([1,1024]);
    ylim([1,1024]);
    zlim([-1024,1024]);
    grid on
    drawnow
    pause(0.005)
    disp(i)
end
clear device