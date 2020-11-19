load('LandmineData.mat');

N = length(feature);

Theta_MLE = zeros(10,N);

for i=1:N
    X_temp = feature{i};
    Y_temp = label{i};
    Theta_MLE(:,i) = mnrfit(X_temp,Y_temp+1);
end

JS = zeros(N,N);

for i=1:N
    for j=i:N
        JS(i,j) = JSdivergence(Theta_MLE(:,i),Theta_MLE(:,j),[feature{i};feature{j}]);
        JS(j,i) = JS(i,j);
    end
end

figure;
myColorMap = colormap;
UIUC_Blue = [19, 41, 75]/255;
UIUC_Orange = [232, 74, 39]/255;
myColorMap(1,:) = UIUC_Orange;
myColorMap(256,:) = UIUC_Blue;

JS_norm = JS/max(max(JS));

imagesc(JS_norm < 0.0825)
colormap(myColorMap)
hold on
h(1) = plot(NaN,NaN,'s','MarkerFaceColor',UIUC_Orange,'MarkerEdgeColor',UIUC_Orange,'MarkerSize',15);
h(2) = plot(NaN,NaN,'s','MarkerFaceColor',UIUC_Blue,'MarkerEdgeColor',UIUC_Blue,'MarkerSize',15);
lgd = legend(h,{'change  ','unchange'},'FontSize',15,'Location','northwest');
set(gca,'YDir','normal')
hold off
