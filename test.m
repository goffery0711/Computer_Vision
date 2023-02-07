classdef test < matlab.unittest.TestCase
    %Test your challenge solution here using matlab unit tests
    %
    % Check if your main file 'challenge.m', 'disparity_map.m' and 
    % verify_dmap.m do not use any toolboxes.
    %
    % Check if all your required variables are set after executing 
    % the file 'challenge.m'   
    properties(TestParameter)
        
        functions = {'challenge.m', 'disparity_map.m', 'verify_dmap.m'};
        
    end
    
    properties
        
        vars = cell(1);
        
    end
    
    methods (TestClassSetup)    
        
        function ClassSetup(test)
            %challenge;
            scene_path = 'terrace\';
            gt_path = scene_path;
            G = pfmread(strcat(gt_path,'disp0.pfm'));
            [D, R, T] = disparity_map(scene_path);
            test.vars{1} = D;
            test.vars{2} = R;
            test.vars{3} = T;
            test.vars{4} = G;
        end
        
    end
    
    methods (Test,ParameterCombination = 'sequential')     
        
        function check_toolboxes(test,functions)
           [~,pList] = matlab.codetools.requiredFilesAndProducts(functions);
           verifyEqual(test,pList.Name,'MATLAB');
        end
        
        function check_variables(test)          
            [~,n] = size(test.vars); 
            for i = 1:n
                verifyNotEmpty(test,test.vars{i});
            end
        end
        
        function check_psnr(test)  
            actualOut = verify_dmap(test.vars{1}, test.vars{4});
            expOut = psnr(uint8(test.vars{1}), uint8(test.vars{4}));
            %var_psnr1 = imnoise(var_psnr2,'salt & pepper', 0.02);
            sub = actualOut-expOut;
            verifyLessThan(test,abs(sub),0.1);            
        end
        
    end
    
end
