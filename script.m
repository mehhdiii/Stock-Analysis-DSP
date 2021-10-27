history = readtable('SPY.csv'); 
history.Properties.VariableDescriptions
bar(history.Date, history.Close, 'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1.5)
xlabel('Years', 'fontsize', 16)
ylabel('Closing Price', 'fontsize', 16)
title('Stock over a period of 10 years')
% figure()
% plot(history.Date, history.Close)

%% 
b1 = ones(1,500)./500;
y_filtered1 = filter(b1,1,history.Close);
bar(history.Date,y_filtered1, 'FaceColor',[0 .9 .5],'EdgeColor',[0 .9 .8],'LineWidth',1.5)
xlabel('Years', 'fontsize', 16)
ylabel('Closing Price', 'fontsize', 16)
title('Long term average')
%%
b2 = ones(1,50)./50
y_filtered2 = filter(b2,1,history.Close)
bar(history.Date,y_filtered2, 'FaceColor',[0 .9 .5],'EdgeColor',[0 .9 .8],'LineWidth',1.5)
xlabel('Years', 'fontsize', 16)
ylabel('Closing Price', 'fontsize', 16)
title('Short term average')

%%

momentum = y_filtered2 - y_filtered1;
bar(history.Date,momentum, 'FaceColor',[0 .9 .5],'EdgeColor',[0 .9 .8],'LineWidth',1.5)
xlabel('Years', 'fontsize', 16)
ylabel('Closing Price', 'fontsize', 16)
title('Momentum')

%%
investment = 10e3; 
threshold =0;
buy=1; 
investment_history=zeros(1, length(history.Date));
investment_history(1) = investment;
shares = investment/history.Close(1);


for i=1:length(history.Date)
    %update investment value at every iteration
    if buy
        investment_history(i) = shares*history.Close(i);
        
    else
        investment_history(i) = investment_history(i-1); 
    end
    
    
    %checking for Momentum
    if momentum(i)>threshold && ~buy
        buy=1; 
        shares = investment_history(i)/history.Close(i); 
    
    else
        if momentum(i)<threshold
        buy=0; 
        end
    end
    
            
    
    
end

%holding stocks still
shares = investment/history.Close(1);
%value today: 
investment_hold = shares*history.Close;

hold on
plot(history.Date,investment_history, 'LineWidth',1.5)
plot(history.Date,investment_hold,'LineWidth',3)
legend('Under Trading Strategy', 'Holding shares')
xlabel('Years')
ylabel('Investment ($)')
% plot(history.Date,y_filtered2,'LineWidth',1.5)
hold off
"Final Investment: " + investment_history(end)
"profit: " + (investment_history(end) - 10000)


%%
sh=[5, 50, 200]; lng=[300, 500, 800]
hold on
for n=1:3
    
    b1 = ones(1,300)./300;
    b2 = ones(1,sh(n))./sh(n);
    y_filtered2 = filter(b2,1,history.Close);
    y_filtered1 = filter(b1,1,history.Close);
    momentum = y_filtered2 - y_filtered1;
    investment = 10e3;
    threshold =0;
    buy=1;
    investment_history=zeros(1, length(history.Date));
    investment_history(1) = investment;
    shares = investment/history.Close(1);
    
    
    for i=1:length(history.Date)
        %update investment value at every iteration
        if buy
            investment_history(i) = shares*history.Close(i);
            
        else
            investment_history(i) = investment_history(i-1);
        end
        
        
        %checking for Momentum
        if momentum(i)>threshold && ~buy
            buy=1;
            shares = investment_history(i)/history.Close(i);
            
        else
            if momentum(i)<threshold
                buy=0;
            end
        end
 
    end

    plot(history.Date,investment_history, 'LineWidth', 1.5)
    drawnow; 
    
end
legend('5', '50', '200')
hold off

figure()
hold on
for n=1:3
    
    b1 = ones(1,lng(n))./lng(n);
    b2 = ones(1,50)./50;
    y_filtered2 = filter(b2,1,history.Close);
    y_filtered1 = filter(b1,1,history.Close);
    momentum = y_filtered2 - y_filtered1;
    investment = 10e3;
    threshold =0;
    buy=1;
    investment_history=zeros(1, length(history.Date));
    investment_history(1) = investment;
    shares = investment/history.Close(1);
    
    
    for i=1:length(history.Date)
        %update investment value at every iteration
        if buy
            investment_history(i) = shares*history.Close(i);
            
        else
            investment_history(i) = investment_history(i-1);
        end
        
        
        %checking for Momentum
        if momentum(i)>threshold && ~buy
            buy=1;
            shares = investment_history(i)/history.Close(i);
            
        else
            if momentum(i)<threshold
                buy=0;
            end
        end
 
    end

    plot(history.Date,investment_history, 'LineWidth', 1.5)
    drawnow; 
    
end
legend('300', '500', '800')
hold off

%%
b1 = ones(1,300)./300;
n1=1:length(b1)
b1 = b1.*exp(-n1)./abs(exp(-n1))
b2 = ones(1,30)./30;
n2=1:length(b2);
b2 = b2.*exp(-n2)./abs(exp(-n2));
y_filtered2 = filter(b2,1,history.Close);
y_filtered1 = filter(b1,1,history.Close);
close all; 
hold on 
plot(history.Date, history.Close,'LineWidth', 5)
plot(history.Date,y_filtered2, 'LineWidth', 3)
plot(history.Date,y_filtered1,'LineWidth', 3)
legend('Stock Prices', 'Exp short', 'Exp long')
title('Exponential Averaging')
hold off 
momentum = y_filtered2 - y_filtered1;
%%
investment = 10e3; 
threshold =8;
buy=1; 
investment_history=zeros(1, length(history.Date));
investment_history(1) = investment;
shares = investment/history.Close(1);


for i=1:length(history.Date)
    %update investment value at every iteration
    if buy
        investment_history(i) = shares*history.Close(i);
        
    else
        investment_history(i) = investment_history(i-1); 
    end
    
    
    %checking for Momentum
    if momentum(i)>threshold && ~buy
        buy=1; 
        shares = investment_history(i)/history.Close(i); 
    
    else
        if momentum(i)<threshold
        buy=0; 
        end
    end
    
            
    
    
end

%holding stocks still
shares = investment/history.Close(1);
%value today: 
investment_hold = shares*history.Close;

hold on
plot(history.Date,investment_history, 'LineWidth',1.5)
plot(history.Date,investment_hold,'LineWidth',3)
legend('Under Trading Strategy', 'Holding shares')
xlabel('Years')
ylabel('Investment ($)')
title('Investment Strategy')
% plot(history.Date,y_filtered2,'LineWidth',1.5)
hold off
"Final Investment: " + investment_history(end)
"profit: " + (investment_history(end) - 10000)

