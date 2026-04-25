clc
clear all
C = [2 3 5];
info = [-2 1 -1; -1 -2 -1];
b = [-4; -6];              

NoVariables = size(info, 2);
s = eye(size(info, 1));
A = [info s b];

Cost = zeros(1, size(A, 2));
Cost(1:NoVariables) = C;

BV = NoVariables + 1 : size(A, 2) - 1;

ZRow = Cost(BV) * A(1:size(info, 1), :) - Cost;

ZjCj = [ZRow; A];
SimpTable = array2table(ZjCj);
SimpTable.Properties.VariableNames = {'x1','x2','x3','s1','s2','Sol'};
disp('Initial Tableau:')
disp(SimpTable)

Run = true;
while Run
    SolCol = A(:, end);
    
    if any(SolCol < -1e-10) 
        fprintf('\nNot feasible. Looking for leaving variable...\n')
        [MinSol, Pvt_Row] = min(SolCol);
        fprintf('Most -ve element in RHS is %.2f in Row %d\n', MinSol, Pvt_Row)
        
        Pvt_Row_Entries = A(Pvt_Row, 1:end-1);
        Ratio = inf(1, size(Pvt_Row_Entries, 2));
        
        for j = 1:size(Pvt_Row_Entries, 2)
            if Pvt_Row_Entries(j) < -1e-10
                Ratio(j) = abs(ZRow(j) / Pvt_Row_Entries(j));
            end
        end
        
        if all(Pvt_Row_Entries >= -1e-10)
            error('The problem is infeasible (No solution exists).');
        end
        
        [MinRatio, Pvt_Col] = min(Ratio);
        fprintf('Minimum Ratio is %.2f corresponding to Column %d\n', MinRatio, Pvt_Col)
        
        fprintf('Leaving Variable: s%d, Entering Variable: x%d\n', BV(Pvt_Row)-NoVariables, Pvt_Col)
        BV(Pvt_Row) = Pvt_Col;
        
        Pvt_Key = A(Pvt_Row, Pvt_Col);
        A(Pvt_Row, :) = A(Pvt_Row, :) ./ Pvt_Key;
        
        for i = 1:size(A, 1)
            if i ~= Pvt_Row
                A(i, :) = A(i, :) - A(i, Pvt_Col) * A(Pvt_Row, :);
            end
        end
        
        ZRow = ZRow - ZRow(Pvt_Col) * A(Pvt_Row, :);
        
        ZjCj = [ZRow; A];
        SimpTable = array2table(ZjCj);
        SimpTable.Properties.VariableNames = {'x1','x2','x3','s1','s2','Sol'};
        disp(SimpTable)
        
    else
        Run = false;
        fprintf('Optimality and Feasibility reached!\n')
        
        FinalBFS = zeros(1, size(A, 2));
        FinalBFS(BV) = A(:, end);
        FinalBFS(end) = sum(FinalBFS(1:end-1) .* Cost(1:end-1));
        
        ResultTable = array2table(FinalBFS);
        ResultTable.Properties.VariableNames = {'x1','x2','x3','s1','s2','Z'};
        disp(ResultTable)
    end
end