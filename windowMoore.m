% Moore window index calculator
function val = windowMoore(mat,i,j)
    global row col
    if (i>=2 && i<row) && (j>=2 && j<col)
        val =[mat(i-1,j-1),mat(i-1,j) ,mat(i-1,j+1),...
              mat(i,j-1)              ,mat(i,j+1),...
              mat(i+1,j-1),mat(i+1,j) ,mat(i-1,j+1)];
    elseif (i==1 && j<col) || (j==1 && i<row)
        val =[            mat(i,j+1),...
              mat(i+1,j) ,mat(i+1,j+1)];
    elseif (i<row && j==col)
        val =[mat(i,j-1)   ,            ...
              mat(i+1,j-1) ,mat(i+1,j)];
    elseif (i==row && j<col)
        val =[mat(i-1,j)   ,mat(i-1,j+1) ...
                            ,mat(i,j+1)];
    elseif (i==row && j==col)
        val =[mat(i-1,j-1)   ,mat(i-1,j),...
              mat(i,j-1)                ];   
    end
end

% % Moore window index calculator
% function val = windowMoore(mat,i,j)
%     global row col
%     if (i>=2 && i<row) && (j>=2 && j<col)
%         val =[mat(i-1,j-1),mat(i-1,j) ,mat(i-1,j+1),...
%               mat(i,j-1)  ,mat(i,j)   ,mat(i,j+1),...
%               mat(i+1,j-1),mat(i+1,j) ,mat(i-1,j+1)];
%     elseif (i==1 && j<col) || (j==1 && i<row)
%         val =[mat(i,j)   ,mat(i,j+1),...
%               mat(i+1,j) ,mat(i+1,j+1)];
%     elseif (i<row && j==col)
%         val =[mat(i,j-1)   ,mat(i,j),...
%               mat(i+1,j-1) ,mat(i+1,j)];
%     elseif (i==row && j<col)
%         val =[mat(i-1,j)   ,mat(i-1,j+1),...
%               mat(i,j) ,mat(i,j+1)];
%     elseif (i==row && j==col)
%         val =[mat(i-1,j-1)   ,mat(i-1,j),...
%               mat(i,j-1) ,mat(i,j)];   
%     end
% end