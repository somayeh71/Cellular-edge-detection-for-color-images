% Multi dimensional Action Selection
function actionTable = actionSelector(P) 
    global A row col
    actionTable = zeros(row,col);
    for i =1:row
        for j =1:col
                p = [P(i,j,1) P(i,j,2)];
                rw = sum(bsxfun(@ge, rand(10,1), cumsum(p./sum(p))),2) + 1;
                actionTable(i,j) = rw(randi(length(rw)));  % selected action
%             rw = randsrc(10,1,[A; P(i,j,1) P(i,j,2)]); % roulette wheel
%             actionTable(i,j) = rw(randi(length(rw)));  % selected action
        end
    end
end