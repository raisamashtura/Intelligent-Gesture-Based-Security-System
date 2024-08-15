clc;
clear all;
close all;

%pass=readmatrix('password.xlsx');
pass=xlsread('password.xlsx');

choice=menu('Please Choose', 'Enter Password', 'Reset Password');
switch choice
    case 1
        given_password=read_password();
        if given_password==pass
            status=1;
        else
            status=0;
        end
        disp(status);
    case 2
        verify_password=read_password();
        if verify_password==pass
            new_password1=read_password();
            new_password2=read_password();
            if new_password1==new_password2
                pass=new_password1;
                save_password(pass);
            else 
                disp('password does not match')
                %break
            end
        else
            disp('password invalid')
        end
end

disp(pass)

