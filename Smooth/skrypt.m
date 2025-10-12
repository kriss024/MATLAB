clear;
load('TestMeasureData.mat');
len=length(Lernphase_Motormoment_kNm);
time=1:len;

figure(1);
plot(time,Lernphase_Motormoment_kNm,'b-');
xlabel('Time');
ylabel('Lernphase Motormoment kNm');
title('Lernphase Motormoment');

% Nearest neighbor interpolation
y_nearest = interp1(time,Lernphase_Motormoment_kNm,'nearest'); 

% Linear interpolation
y_linear = interp1(time,Lernphase_Motormoment_kNm,'linear'); 

% Cubic spline interpolation
y_spline = interp1(time,Lernphase_Motormoment_kNm,'spline'); 

figure(2);
hold on;
plot(time,Lernphase_Motormoment_kNm,'b-');
plot(time,y_nearest,'r.');
plot(time,y_linear,'c.');
plot(time,y_spline,'m.');
xlabel('Time');
ylabel('Lernphase Motormoment kNm');
title('Lernphase Motormoment');
legend('Data','Nearest neighbor','Linear','Cubic spline');
hold off;

% Polynomials interpolation
b = polyfit(time,Lernphase_Motormoment_kNm,1);
y_poly1 = polyval(b,time);

b = polyfit(time,Lernphase_Motormoment_kNm,3);
y_poly3 = polyval(b,time);

b = polyfit(time,Lernphase_Motormoment_kNm,9);
y_poly9 = polyval(b,time);

b = polyfit(time,Lernphase_Motormoment_kNm,16);
y_poly16 = polyval(b,time);

b = polyfit(time,Lernphase_Motormoment_kNm,27);
y_poly27 = polyval(b,time);

figure(3);
hold on;
plot(time,Lernphase_Motormoment_kNm,'b-');
plot(time,y_poly1,'r.');
plot(time,y_poly3,'g.');
plot(time,y_poly9,'b.');
plot(time,y_poly16,'c.');
plot(time,y_poly27,'m.');
xlabel('Time');
ylabel('Lernphase Motormoment kNm');
title('Lernphase Motormoment');
legend('Data','1 degree','3 degree','9 degree','16 degree','27 degree');
hold off;