clear;
load('TestMeasureData.mat');

% get sample of data
step=50;
ii=1;
i=1;
while(i<length(Lernphase_Motormoment_kNm))
     y(ii) = Lernphase_Motormoment_kNm(i);
     i = i + step;
     ii = ii +1;
end


len=length(y);
time=1:len;

figure(1);
plot(time,y,'b-');
xlabel('Time');
ylabel('Lernphase Motormoment kNm');
title('Lernphase Motormoment');
legend('Data');

% Moving average
y_smooth1 = smooth(time,y,0.1,'moving'); 

% Local regression using weighted linear least squares
% Smooth the data using the loess and rloess methods with a span of 10%
y_smooth2 = smooth(time,y,0.1,'loess');  

% A robust version of 'lowess'
y_smooth3 = smooth(time,y,0.1,'rloess');

figure(2);
hold on;
plot(time,y,'b-');
plot(time,y_smooth1,'r.');
plot(time,y_smooth2,'c.');
plot(time,y_smooth3,'m.');
xlabel('Time');
ylabel('Lernphase Motormoment kNm');
title('Lernphase Motormoment');
legend('Data','Moving average','Local regression','A robust version of local reg.');
hold off;

% Polynomials interpolation
b = polyfit(time,y,1);
y_poly1 = polyval(b,time);

b = polyfit(time,y,3);
y_poly3 = polyval(b,time);

b = polyfit(time,y,9);
y_poly9 = polyval(b,time);

b = polyfit(time,y,16);
y_poly16 = polyval(b,time);

b = polyfit(time,y,27);
y_poly27 = polyval(b,time);

figure(3);
hold on;
plot(time,y,'b-');
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