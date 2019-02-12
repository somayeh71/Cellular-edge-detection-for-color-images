function J = CLA_G_ED_final( I )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
alpha = .5; beta = .5;
global A row col

[row,col] = size(I);
r = 2; %	Number of Actions
% A = [0 1]; %  Actions or AA = [1 2]
A = [1 2];
P(:,:,1) = repmat(1/r,row,col); % action 1 probability vector as action 1
P(:,:,2) = repmat(1/r,row,col); % action 1 probability vector as action 2

J = zeros(row,col);
Teta = 30;


for gene = 0:10
    actionTable = actionSelector(P);
    for i=1:row
        for j=1:col
            act = actionTable(i,j);
            negact = A(A ~= act);
            switch lower(act)
                case (1)
                    nVal = windowMoore(I,i,j);                    
                case (2)
                    nVal = windowVonNeumann(I,i,j);
            end
            nVal = sort(nVal);
            if abs(I(i,j) - nVal(1)) >= Teta
                J(i,j) = 1;
            end
            nAction = windowMoore(actionTable,i,j); % neighberhood Actions
            if act == nAction
                P(i,j,act) = P(i,j,act) + alpha.*(1 - P(i,j,act));  % desired action
                P(i,j,negact) = (1-alpha).*P(i,j,negact);
            elseif act ~= nAction
                P(i,j,act) = (1 - beta).*P(i,j,act);   % non-desired action
                P(i,j,negact) = (beta/(r-1))+(1-beta).*P(i,j,negact);    
            end
        end
    end
%       fprintf('Generation=%u \n',gene)
      %pause(.1), imshow(J), drawnow

end


end

