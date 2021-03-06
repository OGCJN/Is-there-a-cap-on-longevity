function varargout = LATool(varargin)
% LATOOL MATLAB code for LATool.fig
%      LATOOL, by itself, creates a new LATOOL or raises the existing
%      singleton*.
%
%      H = LATOOL returns the handle to a new LATOOL or the handle to
%      the existing singleton*.
%
%      LATOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LATOOL.M with the given input arguments.
%
%      LATOOL('Property','Value',...) creates a new LATOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LATool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LATool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LATool

% Last Modified by GUIDE v2.5 08-May-2021 18:55:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LATool_OpeningFcn, ...
                   'gui_OutputFcn',  @LATool_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before LATool is made visible.
function LATool_OpeningFcn(hObject, ~, handles, varargin)

    handles.output = hObject;

    Countries = {'Austria','AUT',0,0,0,0,0,0,0,0,0,0;
                 'Belgium','BEL',0,0,0,0,0,0,0,0,0,0;
                 'Canada','CAN',0,0,0,0,0,0,0,0,0,0;
                 'Denmark','DNK',0,0,0,0,0,0,0,0,0,0;
                 'Finland','FIN',0,0,0,0,0,0,0,0,0,0;
                 'France','FRA',0,0,0,0,0,0,0,0,0,0;
                 'Germany','DEU',0,0,0,0,0,0,0,0,0,0;
                 'Italy','ITA',0,0,0,0,0,0,0,0,0,0;
                 'Japan','JPN',0,0,0,0,0,0,0,0,0,0;
                 'Norway','NOR',0,0,0,0,0,0,0,0,0,0;
                 'Spain','ESP',0,0,0,0,0,0,0,0,0,0;
                 'Sweden','SWE',0,0,0,0,0,0,0,0,0,0;
                 'Lebabon','LBN',0,0,0,0,0,0,0,0,0,0;
                 'England & Wales','EW',0,0,0,0,0,0,0,0,0,0;
                 'United States','USA',0,0,0,0,0,0,0,0,0,0;};

    if exist('data.mat', 'file') ~= 2
        
        uiwait(msgbox('To use LATool you must obtain the .mat files with the data and put them in the same folder as LATool.m. Please contact the authors for more details.','LATool: loading data...','modal'));
        
        web('http://www.supercentenarians.org/DataBase');
        
        handles.closeFigure = true;
        
        guidata(hObject, handles);
        
        return;
        
    end  
 
    tmp = load('data.mat','data');
    handles.data = tmp.data;
    
    handles.newIDL = true;
    
    set(handles.checkboxNewIDL,'Value',handles.newIDL);   
    
    if exist('fra2019.mat', 'file') == 2
        
        Countries = [Countries; {'FRA2019','FRA2019',0,0,0,0,0,0,0,0,0,0;}];
        
        tmp = load('fra2019.mat','fra2019');
        
        handles.data = [handles.data; tmp.fra2019];
        
        guidata(hObject, handles);
        handles = guidata(hObject);
        
    end    
    
     if exist('uk2020.mat', 'file') == 2
        
        Countries = [Countries; {'UK2020','UK2020',0,0,0,0,0,0,0,0,0,0;}];
        
        tmp = load('uk2020.mat','uk2020');
        
        handles.data = [handles.data; tmp.uk2020];
        
        guidata(hObject, handles);
        handles = guidata(hObject);
        
     end     
    
     if exist('usa2020.mat', 'file') == 2
        
        Countries = [Countries; {'USA2020','USA2020',0,0,0,0,0,0,0,0,0,0;}];
        
        tmp = load('usa2020.mat','usa2020');
        
        handles.data = [handles.data; tmp.usa2020];
        
        guidata(hObject, handles);
        handles = guidata(hObject);
        
     end   
    
     if exist('nld.mat', 'file') == 2
        
        Countries = [Countries; {'Netherlands','NLD',0,0,0,0,0,0,0,0,0,0;}];
        
        tmp = load('nld.mat','nld');
        
        handles.data = [handles.data; tmp.nld];
        
        guidata(hObject, handles);
        handles = guidata(hObject);
        
     end  
    
     if exist('EW2021.mat', 'file') == 2
        
        Countries = [Countries; {'EW Extended','EW2021',0,0,0,0,0,0,0,0,0,0;}];
        
        tmp = load('EW2021.mat','EW2021');
        
        handles.data = [handles.data; tmp.EW2021];
        
        guidata(hObject, handles);
        handles = guidata(hObject);
        
    end       
          
    if exist('barbi.mat', 'file') == 2
        
        Countries = [Countries; {'ISTAT, ALL YEARS','ISTAT',0,0,0,0,0,0,0,0,0,0;}];
        
        tmp = load('barbi.mat','barbi');
        
        handles.data = [handles.data; tmp.barbi];
        
        guidata(hObject, handles);
        handles = guidata(hObject);
        
        birth_dates_all = floor(cell2mat(tmp.barbi(:,8))/10000);
        birth_dates_unique = unique(birth_dates_all);
        
        for i = 1:numel(birth_dates_unique)
            
            birth_year = birth_dates_unique(i);
            
            new_dataset = tmp.barbi(birth_dates_all == birth_year,:);
            
            new_dataset(:,6) = {['ISTAT ' num2str(birth_year)]};
            new_dataset(:,7) = {['ISTAT ' num2str(birth_year)]};
            
            Countries = [Countries; {['ISTAT ' num2str(birth_year)],['ISTAT ' num2str(birth_year)],0,0,0,0,0,0,0,0,0,0;}]; %#ok<AGROW>
            
            handles.data = [handles.data; new_dataset];
            
        end
        
    end   
    
    handles.LBAUTSEMI  = 2003;
    handles.UBAUTSEMI  = 2014;
    handles.LBBELSEMI  = 1977;
    handles.UBBELSEMI  = 2015;
    handles.LBCANSEMI  = 1985;
    handles.UBCANSEMI  = 2009;
    handles.LBDNKSEMI  = 1970;
    handles.UBDNKSEMI  = 2014;
    handles.LBFINSEMI  = nan(1);
    handles.UBFINSEMI  = nan(1);
    handles.LBFRASEMI  = 1978;
    handles.UBFRASEMI  = 2017;
    handles.LBDEUSEMI  = 1989;
    handles.UBDEUSEMI  = 2005;
    handles.LBJPNSEMI  = nan(1);
    handles.UBJPNSEMI  = nan(1);
    handles.LBNORSEMI  = 1986;
    handles.UBNORSEMI  = 2006;
    handles.LBESPSEMI  = nan(1);
    handles.UBESPSEMI  = nan(1);
    handles.LBSWESEMI  = nan(1);
    handles.UBSWESEMI  = nan(1);     
    handles.LBEWSEMI   = 2000;
    handles.UBEWSEMI   = 2014;
    handles.LBUSASEMI  = nan(1);
    handles.UBUSASEMI  = nan(1);
    
    handles.LBAUTSUPER = 2005;
    handles.UBAUTSUPER = 2012;
    handles.LBBELSUPER = 1990;
    handles.UBBELSUPER = 2015;
    handles.LBCANSUPER = 1983;
    handles.UBCANSUPER = 2009;
    handles.LBDNKSUPER = 1996;
    handles.UBDNKSUPER = 2014;
    handles.LBFINSUPER = 1989;
    handles.UBFINSUPER = 2006;
    handles.LBFRASUPER = 1987;
    handles.UBFRASUPER = 2017;
    handles.LBDEUSUPER = 1994;
    handles.UBDEUSUPER = 2005;
    handles.LBJPNSUPER = 1996;
    handles.UBJPNSUPER = 2005;
    handles.LBNORSUPER = 1989;
    handles.UBNORSUPER = 2004;
    handles.LBESPSUPER = 1989;
    handles.UBESPSUPER = 2016;
    handles.LBSWESUPER = 1986;
    handles.UBSWESUPER = 2003;
    handles.LBEWSUPER  = 1968;
    handles.UBEWSUPER  = 2017;
    handles.LBUSASUPER = 1980;
    handles.UBUSASUPER = 2010;

    handles.filter_enabled = false;
    
    if exist('filter.txt', 'file') == 2

        fid = fopen('filter.txt');
        tline = fgetl(fid);
        
        % skip first line
        if ischar(tline) 
           
            tline = fgetl(fid);
            
        end
        
        while ischar(tline)
            
            str_items = strsplit(tline);
            
            country = str_items{1};
            
            I = strcmp(handles.data(:,7), country); 
            
            after = str2num(str_items{2});
            
            before = str2num(str_items{3});
            
            u = str2num(str_items{4});

            I = I & ((cell2mat(handles.data(:,9)) < after) | (cell2mat(handles.data(:,9)) > before) | (cell2mat(handles.data(:,11)) < u));

            handles.data(I,:) = [];
                       
            if strcmp(country,'AUT')
                handles.LBAUTSUPER = max(handles.LBAUTSUPER, after);
                handles.UBAUTSUPER = min(handles.UBAUTSUPER, before);               
                handles.LBAUTSEMI  = max(handles.LBAUTSEMI , after);
                handles.UBAUTSEMI  = min(handles.UBAUTSEMI , before);
            elseif strcmp(country,'BEL')
                handles.LBBELSUPER = max(handles.LBBELSUPER, after);
                handles.UBBELSUPER = min(handles.UBBELSUPER, before);
                handles.LBBELSEMI  = max(handles.LBBELSEMI , after);
                handles.UBBELSEMI  = min(handles.UBBELSEMI , before);              
            elseif strcmp(country,'CAN')
                handles.LBCANSUPER = max(handles.LBCANSUPER, after);
                handles.UBCANSUPER = min(handles.UBCANSUPER, before);
                handles.LBCANSEMI  = max(handles.LBCANSEMI , after);
                handles.UBCANSEMI  = min(handles.UBCANSEMI , before);      
            elseif strcmp(country,'DNK')
                handles.LBDNKSUPER = max(handles.LBDNKSUPER, after);
                handles.UBDNKSUPER = min(handles.UBDNKSUPER, before);
                handles.LBDNKSEMI  = max(handles.LBDNKSEMI , after);
                handles.UBDNKSEMI  = min(handles.UBDNKSEMI , before);      
            elseif strcmp(country,'FIN')
                handles.LBFINSUPER = max(handles.LBFINSUPER, after);
                handles.UBFINSUPER = min(handles.UBFINSUPER, before);
                handles.LBFINSEMI  = min(handles.LBFINSEMI , after);
                handles.UBFINSEMI  = min(handles.UBFINSEMI , before);      
            elseif strcmp(country,'FRA')
                handles.LBFRASUPER = max(handles.LBFRASUPER, after);
                handles.UBFRASUPER = min(handles.UBFRASUPER, before);
                handles.LBFRASEMI  = max(handles.LBFRASEMI , after);
                handles.UBFRASEMI  = min(handles.UBFRASEMI , before);      
            elseif strcmp(country,'DEU')
                handles.LBDEUSUPER = max(handles.LBDEUSUPER, after);
                handles.UBDEUSUPER = min(handles.UBDEUSUPER, before);
                handles.LBDEUSEMI  = max(handles.LBDEUSEMI , after);
                handles.UBDEUSEMI  = min(handles.UBDEUSEMI , before);      
            elseif strcmp(country,'ITA')

            elseif strcmp(country,'JPN')
                handles.LBJPNSUPER = max(handles.LBJPNSUPER, after);
                handles.UBJPNSUPER = min(handles.UBJPNSUPER, before);
                handles.LBJPNSEMI  = max(handles.LBJPNSEMI , after);
                handles.UBJPNSEMI  = min(handles.UBJPNSEMI , before);                
            elseif strcmp(country,'NOR')
                handles.LBNORSUPER = max(handles.LBNORSUPER, after);
                handles.UBNORSUPER = min(handles.UBNORSUPER, before);
                handles.LBNORSEMI  = max(handles.LBNORSEMI , after);
                handles.UBNORSEMI  = min(handles.UBNORSEMI , before);      
            elseif strcmp(country,'ESP')
                handles.LBESPSUPER = max(handles.LBESPSUPER, after);
                handles.UBESPSUPER = min(handles.UBESPSUPER, before); 
                handles.LBESPSEMI  = max(handles.LBESPSEMI , after);
                handles.UBESPSEMI  = min(handles.UBESPSEMI , before);      
            elseif strcmp(country,'SWE')
                handles.LBSWESUPER = max(handles.LBSWESUPER, after);
                handles.UBSWESUPER = min(handles.UBSWESUPER, before); 
                handles.LBSWESEMI  = max(handles.LBSWESEMI , after);
                handles.UBSWESEMI  = min(handles.UBSWESEMI , before);      
            elseif strcmp(country,'CHE')

            elseif strcmp(country,'EW') || strcmp(country,'EW2021')
                handles.LBEWSUPER  = max(handles.LBEWSUPER , after);
                handles.UBEWSUPER  = min(handles.UBEWSUPER , before);
                handles.LBEWSEMI   = max(handles.LBEWSEMI  , after);
                handles.UBEWSEMI   = min(handles.UBEWSEMI  , before);      
            elseif strcmp(country,'USA')
                handles.LBUSASUPER = max(handles.LBUSASUPER, after);
                handles.UBUSASUPER = min(handles.UBUSASUPER, before);
                handles.LBUSASEMI  = max(handles.LBUSASEMI , after);
                handles.UBUSASEMI  = min(handles.UBUSASEMI , before);      
            elseif strncmp(country,'ISTAT',5)
            elseif strncmp(country,'FRA2019',7)
            elseif strncmp(country,'NLD',7)
            else
            end                         
            
            tline = fgetl(fid);
            
        end
        
        fclose(fid);
        
        handles.filter_enabled = true;
        
        guidata(hObject, handles);
        
    end
    
    set(handles.checkboxFilterTXT,'Value', handles.filter_enabled);

    handles.countries = Countries;
    handles.SelectedCountries = 1;
    handles.Excluded = cell2mat(handles.data(:,12));
    handles.Before = 2050;
    handles.After = 1950;
    handles.u = 110;

    handles.MakePOTPlots = false;
    
    handles.PoissonFrom = 1975;
    handles.PoissonTo = 1995;

    handles.CrapThreshold = 1994.5;

    handles.UnbiasedEstimation = false;

    for k = 1:size(Countries,1)
        
       Countries{k,3} = sum(strcmp(handles.data(:,5),'M')&strcmp(handles.data(:,7),Countries(k,2)));
       Countries{k,4} = sum(strcmp(handles.data(:,5),'F')&strcmp(handles.data(:,7),Countries(k,2)));
       Countries{k,5} = sum(strcmp(handles.data(:,7),Countries(k,2)));   
       Countries{k,6} = sum((cell2mat(handles.data(:,12))>0)&strcmp(handles.data(:,7),Countries(k,2))); 
       
       E = (cell2mat(handles.data(:,12)) > 0)|(cell2mat(handles.data(:,11))<=handles.u-0.00001);
       C = strcmp(handles.data(:,7),Countries(k,2));
       
       x = cell2mat(handles.data(C&(~E),11));
       
       if (numel(x) > 0)
       
           [par, CI] = gpfit(x(x>=handles.u)-handles.u+0.00001);

           Countries{k,7} = par(1);
           Countries{k,8} = CI(1,1);
           Countries{k,9} = CI(2,1);

           Countries{k,10} = par(2);
           Countries{k,11} = CI(1,2);
           Countries{k,12} = CI(2,2);

       end 
       
    end

    set(handles.TableCountries, 'Data', Countries); 
    set(0,'DefaultFigureRenderer','zbuffer');

    axes(handles.axesLogo);
    cla;
    I = imread('logo.jpg');
    imagesc(I)
    set(gca,'XTick',[]);
    set(gca,'YTick',[]);
    box on;

    guidata(hObject, handles);
    handles = guidata(hObject);

    I = cell2mat(handles.data(:,1));
    handles.S = zeros(1,numel(I));
    V = cell2mat(handles.data(I == 584,12));
    if sum(V) ~= 0
        set(handles.checkboxJC,'Value',0)
        checkboxJC_Callback(hObject, [], handles);
    end

    handles = guidata(hObject);

    axes(handles.axesScatter);
    box on;

    MakeScatterPlot(hObject,handles);

    guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = LATool_OutputFcn(hObject, ~, handles) 

    varargout{1} = handles.output;
    
    if (isfield(handles,'closeFigure') && handles.closeFigure)
        delete(hObject);
    end

%% Log-likelihoods naive    
    
% Log-likelihood exponential (naive) = log(f(x))    
function LL = LLExp(sigma,x)

    n  =  numel(x);
    
    LL = -n*log(sigma)-sum(x)/sigma;      

    
% Log-likelihood Generalized Pareto (naive) = log(f(x))        
function LL = LLGPD(gamma,sigma,x)

    eps=0.000000001;

    if abs(gamma) < eps
        
        LL = LLExp(sigma,x);
        
    else
        
        n  =  numel(x);
        
        LL = -n*log(sigma)-(1/gamma+1)*sum(log(1+gamma/sigma*x));    
        
    end

%% Log-likelihoods corrected 
    
% Log-likelihood exponential, with correction for truncation, censoring
% and those who are still alive
function LL=LLExpUnbiased(sigma,xi,ti,bi,ei,isbarbi,isalive)

    emt = ei - ti;
    bmt = bi - ti;    

    LL = 0;
        
    %% Not Barbi data
    n  = sum(~isbarbi);
        
    if n > 0
              
       LL = - n * log(sigma) - sum(xi(~isbarbi))/sigma ... 
                             - sum( log( exp(-max(0,bmt(~isbarbi))/sigma) - exp(-emt(~isbarbi)/sigma) ) );
     
    end 

    %% Barbi data

    n = sum(isbarbi);    
        
    if n>0 
        
        n_dead = n - sum(isbarbi & isalive);
                
        LL = LL - n_dead*log(sigma) - ( sum(xi(isbarbi)) - sum(max(0,bmt(isbarbi))) )/sigma;
  
    end
     
     
% Log-likelihood Generalized Pareto, with correction for truncation, censoring
% and those who are still alive
function LL=LLGPDUnbiased(gamma,sigma,xi,ti,bi,ei,isbarbi,isalive)

    eps=0.000000001;
    
    if abs(gamma) < eps
        
        LL = LLExpUnbiased(sigma,xi,ti,bi,ei,isbarbi,isalive);
        
    else

        LL = 0;
        
        emt = ei - ti;
        bmt = bi - ti;    
        
        %% Not Barbi data
        n = sum(~isbarbi);

        if n>0

            LL = -n * log(sigma) - (1/gamma+1)*sum( log( (1+(gamma/sigma)*xi(~isbarbi)) ) )...
                                             - sum( log( (1+(gamma/sigma)*max(0,bmt(~isbarbi))).^(-1/gamma) - (1+(gamma/sigma)*emt(~isbarbi)).^(-1/gamma) ) );   
        end
        
        %% Barbi data
               
        n = sum(isbarbi);
        
        if n>0
            
            n_dead = n - sum(isbarbi & isalive);
            
            LL = LL - n_dead*log(sigma) - (1/gamma+1)*sum(log(1+(gamma/sigma)*xi(isbarbi & (~isalive))))...
                                        - (1/gamma  )*sum(log(1+(gamma/sigma)*xi(isbarbi & ( isalive))))...
                                        + (1/gamma  )*sum(log(1+(gamma/sigma)*(max(0,bmt(isbarbi)))));  
            
        end
         
    end    
    
%% Log-likelihoods corrected, estimation    

% Exponential
function [par, CI]=EstimateExpUnbiased(xi,ti,bi,ei,isbarbi,isalive) 
    
    eps=0.0000001;

    if sum(~isbarbi) == 0
        disp(['Exact formula for the exponential case (ISTAT data) gives: ' num2str((sum(xi(isbarbi)) - sum(max(bi(isbarbi) - ti(isbarbi),0))) / sum(isbarbi&(~isalive)))]);
    end
    
    sigma = fmincon(@(x) -LLExpUnbiased(x,xi,ti,bi,ei,isbarbi,isalive),...
                    1,[],[],[],[],eps,20,[],... 
                    optimoptions(@fmincon,'Algorithm','interior-point',...
                                          'TolX',1e-12,...
                                          'Display','Off'));

    CI = [nan(1), nan(1)];
    
    Hessian = hessian(@(x) -LLExpUnbiased(x,xi,ti,bi,ei,isbarbi,isalive),sigma);

    if isreal(Hessian) || imag(Hessian) < 0.00000001
        
        Hessian = real(Hessian);
        
        if Hessian(1,1)~=0

          Var_sigma = 1/Hessian(1,1);

          if (Var_sigma > 0)

              Csigma = 1.96*sqrt(Var_sigma);

              CI = [sigma - Csigma, sigma + Csigma];

          end

        else

          CI = [-inf inf];

          disp('Hessian is degenerate. Confidence interval for the Exponential parameter (unbiased estimation) is not reliable.');

        end
    
    else
        disp('Hessian estimation failed. Confidence interval for the Exponential parameter (unbiased estimation) is not reliable.');
    end
    
    par = sigma;

% Generalized Pareto    
function [par, CI]=EstimateGPDUnbiased(xi,ti,bi,ei,isbarbi,isalive) 

    eps=0.0000001;
    
    maxxi = max(xi);
    
    bmt = bi - ti;
    emt = ei - ti;
           
    C = max([maxxi max(bmt) max(emt(~isbarbi))]);

    x0=fmincon(@(x) -LLExpUnbiased(x,xi,ti,bi,ei,isbarbi,isalive),1,[],[],[],[]...
                                                                 ,eps,20,[],...
               optimoptions(@fmincon,'Algorithm','interior-point','TolX',1e-12,'Display','Off'));

    x1=fmincon(@(x) -LLGPDUnbiased(x(1),x(2),xi,ti,bi,ei,isbarbi,isalive), [0.5 maxxi]...
                                                                         , [-C, -1],-eps...
                                                                         , [],[]...
                                                                         , [eps eps],[10 20]...
                                                                         , [],...
               optimoptions(@fmincon,'Algorithm','interior-point','TolX',1e-12,'Display','Off'));

    x2=fmincon(@(x) -LLGPDUnbiased(x(1),x(2),xi,ti,bi,ei,isbarbi,isalive), [-maxxi/(2*C) maxxi ]...
                                                                         , [-C, -1],-eps...
                                                                         , [],[]...
                                                                         , [-1 eps],[eps 20],[],...
               optimoptions(@fmincon,'Algorithm','interior-point','TolX',1e-12,'Display','Off'));

    if -LLGPDUnbiased(x1(1),x1(2),xi,ti,bi,ei,isbarbi,isalive) < -LLExpUnbiased(x0,xi,ti,bi,ei,isbarbi,isalive)
        
        if  -LLGPDUnbiased(x1(1),x1(2),xi,ti,bi,ei,isbarbi,isalive) < -LLGPDUnbiased(x2(1),x2(2),xi,ti,bi,ei,isbarbi,isalive)
            x = x1;
        else
            x = x2;
        end
        
    elseif -LLGPDUnbiased(x2(1),x2(2),xi,ti,bi,ei,isbarbi,isalive) < -LLExpUnbiased(x0,xi,ti,bi,ei,isbarbi,isalive)
        
        x = x2;     
        
    else
        
        x = [0 x0]; 
        
    end

    gamma = x(1);
    sigma = x(2);
    
    % Confidence intervals for unbiased estimation for the GPD may not be
    % reliable for gamma close to zero!!!

    CI = nan(2);
    
    Hessian = hessian(@(x) -LLGPDUnbiased(x(1),x(2),xi,ti,bi,ei,isbarbi,isalive),x);
    
    if isreal(Hessian) || max(max(imag(Hessian))) < 0.00000001
        
        Hessian = real(Hessian);
        
        DetH = Hessian(1,1)*Hessian(2,2) - Hessian(1,2)*Hessian(2,1);

        if DetH ~= 0
            
          Var_gamma = Hessian(2,2)/DetH;
          Var_sigma = Hessian(1,1)/DetH;
          
          if (Var_gamma > 0) && (Var_sigma > 0)
              
              Cgamma = 1.96*sqrt(Var_gamma);
              Csigma = 1.96*sqrt(Var_sigma);
              
              CI = [gamma - Cgamma, gamma + Cgamma;... 
                    sigma - Csigma, sigma + Csigma];
       
          end
          
        else
            
          CI = inf(2);
          
          disp('Hessian is degenerate. Confidence intervals for the GPD parameters (unbiased estimation) are not reliable.');
          
        end

    else
        
        disp('Hessian estimation failed. Confidence intervals for the GPD parameters (unbiased estimation) are not reliable.');
        
    end
    
    par = [gamma sigma]';


% ---- Log-likelihoods, end ---    
    
    
function [y, CriticalValue]=KSCDF(x,n,alpha)

    % Monte-Carlo approximation for cumulative distribution function of Dn. 
    % Dn is a goodness of fit test statistics for exponential distribution with 
    % unknown rate, x is a scalar.  

    maxiter=10;
    ncut=100;
    m=100000;

    if n>ncut    
        x=sqrt(n/ncut)*x;
        n0=ncut;
    else
        n0=n;
    end

    if (x<1/(2*n0))||(x>1)
        e=sort(exprnd(1,m,n0),2);
        Sx=repmat((1:n0)/n0,m,1);
        Fx=1-(1-e./repmat(n0*mean(e,2),1,n0)).^(n0-1);
        Dn=sort(max(max(abs(Sx-Fx),[],2),max(abs(Sx-Fx-1/n0),[],2)));
        CriticalValue=Dn(end-ceil(alpha*m));
        y=0*(x<1/(2*n0))+1*(x>1);
        return;
    else
        k=0;
        i=0;
        while ((k<20)||((i*m-k<20)&&(i>0)))&&(i<maxiter)
            e=sort(exprnd(1,m,n0),2);
            Sx=repmat((1:n0)/n0,m,1);
            Fx=1-(1-e./repmat(n0*mean(e,2),1,n0)).^(n0-1);
            Dn=max(max(abs(Sx-Fx),[],2),max(abs(Sx-Fx-1/n0),[],2));
            k=k+sum(Dn<=x);
            i=i+1;
        end
        y=k/(i*m);
    end

    Dn=sort(Dn);
    CriticalValue=Dn(end-ceil(alpha*m));

    if n>ncut
        CriticalValue=sqrt(ncut/n)*CriticalValue;    
    end     
     
% --- Executes when selected cell(s) is changed in TableCountries.
function TableCountries_CellSelectionCallback(hObject, eventdata, handles) 
    handles.SelectedCountries = unique(eventdata.Indices(:,1));
    guidata(hObject, handles);
    MakeScatterPlot(hObject,handles);

function [y] = YYYYMMDD2Year(x)
    y = floor(x/10000) + (floor(mod(x,10000)/100)-1+(mod(x,100)-0.00001)/31)/12;

function [LB, UB] = CensoringBounds(handles, country)

    if handles.newIDL
        
        if handles.u >=110 
            
            if strcmp(country,'AUT')
                LB=handles.LBAUTSUPER;
                UB=handles.UBAUTSUPER;
            elseif strcmp(country,'BEL')
                LB=handles.LBBELSUPER;
                UB=handles.UBBELSUPER;
            elseif strcmp(country,'CAN')
                LB=handles.LBCANSUPER;
                UB=handles.UBCANSUPER; 
            elseif strcmp(country,'DNK')
                LB=handles.LBDNKSUPER;
                UB=handles.UBDNKSUPER;
            elseif strcmp(country,'FIN')
                LB=handles.LBFINSUPER;
                UB=handles.UBFINSUPER;
            elseif strcmp(country,'FRA')
                LB=handles.LBFRASUPER;
                UB=handles.UBFRASUPER;
            elseif strcmp(country,'DEU')
                LB=handles.LBDEUSUPER;
                UB=handles.UBDEUSUPER;
            elseif strcmp(country,'ITA')
                LB=1973;
                UB=2004;  
            elseif strcmp(country,'JPN')
                LB=handles.LBJPNSUPER;
                UB=handles.UBJPNSUPER; 
                
                if get(handles.checkboxExcludeJapanAfter2000,'Value') == 1

                    UB = min(UB,YYYYMMDD2Year(20040901)); 

                end 

            elseif strcmp(country,'NOR')
                LB=handles.LBNORSUPER;
                UB=handles.UBNORSUPER; 
            elseif strcmp(country,'ESP')
                LB=handles.LBESPSUPER;
                UB=handles.UBESPSUPER; 
            elseif strcmp(country,'SWE')
                LB=handles.LBSWESUPER;
                UB=handles.UBSWESUPER;   
            elseif strcmp(country,'CHE')
                LB=1993;
                UB=2001; 
            elseif strcmp(country,'EW') || strcmp(country,'EW2021')
                LB=handles.LBEWSUPER;
                UB=handles.UBEWSUPER; 
            elseif strcmp(country,'USA')
                LB=handles.LBUSASUPER;
                UB=handles.UBUSASUPER; 
                
                if get(handles.checkboxExcludeUSAAfter2000,'Value') == 1

                   UB=min(UB,2000); 

                end
                
            elseif strncmp(country,'ISTAT',5)
                LB=YYYYMMDD2Year(20090101);
                UB=YYYYMMDD2Year(20151231);     
            elseif strncmp(country,'FRA2019',7)
                LB=1978;
                UB=2017;        
            elseif strncmp(country,'NLD',7)
                LB=1985.93;
                UB=2016.07;              
            else
                LB=nan(1);
                UB=nan(1);         
            end             
            
        else
            
            if strcmp(country,'AUT')
                LB=handles.LBAUTSEMI;
                UB=handles.UBAUTSEMI;
            elseif strcmp(country,'BEL')
                LB=handles.LBBELSEMI;
                UB=handles.UBBELSEMI;
            elseif strcmp(country,'CAN')
                LB=handles.LBCANSEMI;
                UB=handles.UBCANSEMI; 
            elseif strcmp(country,'DNK')
                LB=handles.LBDNKSEMI;
                UB=handles.UBDNKSEMI;
            elseif strcmp(country,'FIN')
                LB=handles.LBFINSEMI;
                UB=handles.UBFINSEMI;
            elseif strcmp(country,'FRA')
                LB=handles.LBFRASEMI;
                UB=handles.UBFRASEMI;
            elseif strcmp(country,'DEU')
                LB=handles.LBDEUSEMI;
                UB=handles.UBDEUSEMI;
            elseif strcmp(country,'ITA')
                LB=1973;
                UB=2004;  
            elseif strcmp(country,'JPN')
                LB=handles.LBJPNSEMI;
                UB=handles.UBJPNSEMI; 
                
                if get(handles.checkboxExcludeJapanAfter2000,'Value') == 1

                    UB = min(UB,YYYYMMDD2Year(20040901)); 

                end 
                
            elseif strcmp(country,'NOR')
                LB=handles.LBNORSEMI;
                UB=handles.UBNORSEMI; 
            elseif strcmp(country,'ESP')
                LB=handles.LBESPSEMI;
                UB=handles.UBESPSEMI; 
            elseif strcmp(country,'SWE')
                LB=handles.LBSWESEMI;
                UB=handles.UBSWESEMI;   
            elseif strcmp(country,'CHE')
                LB=1993;
                UB=2001; 
            elseif strcmp(country,'EW') || strcmp(country,'EW2021')
                LB=handles.LBEWSEMI;
                UB=handles.UBEWSEMI; 
            elseif strcmp(country,'USA')
                LB=handles.LBUSASEMI;
                UB=handles.UBUSASEMI; 
                
                if get(handles.checkboxExcludeUSAAfter2000,'Value') == 1

                   UB=min(UB,2000); 

                end

            elseif strncmp(country,'ISTAT',5)
                LB=YYYYMMDD2Year(20090101);
                UB=YYYYMMDD2Year(20151231);     
            elseif strncmp(country,'FRA2019',7)
                LB=1978;
                UB=2017;        
            elseif strncmp(country,'NLD',7)
                LB=1985.93;
                UB=2016.07;              
            else
                LB=nan(1);
                UB=nan(1);         
            end              
            
        end

    else 

        if strcmp(country,'AUT')
            LB=1990;
            UB=2005;
        elseif strcmp(country,'BEL')
            LB=1993;
            UB=2003;
        elseif strcmp(country,'CAN')
            LB=1962;
            UB=2003; 
        elseif strcmp(country,'DNK')
            LB=1996;
            UB=2001;
        elseif strcmp(country,'FIN')
            LB=1989;
            UB=2007;
        elseif strcmp(country,'FRA')
            LB=1987;
            UB=2004;
        elseif strcmp(country,'DEU')
            LB=1994;
            UB=2006;
        elseif strcmp(country,'ITA')
            LB=1973;
            UB=2004;  
        elseif strcmp(country,'JPN')
            
            LB=YYYYMMDD2Year(19960930);
            
            if get(handles.checkboxExcludeJapanAfter2000,'Value') == 1
                        
                UB = YYYYMMDD2Year(20040901); 
                       
            else             
            
                UB = YYYYMMDD2Year(20050930); 
                
            end 
            
        elseif strcmp(country,'NOR')
            LB=1989;
            UB=2005; 
        elseif strcmp(country,'ESP')
            LB=1987;
            UB=2008; 
        elseif strcmp(country,'SWE')
            LB=1986;
            UB=2004;   
        elseif strcmp(country,'CHE')
            LB=1993;
            UB=2001; 
        elseif strcmp(country,'EW') || strcmp(country,'EW2021')
            LB=1968;
            UB=2007; 
        elseif strcmp(country,'USA')
            
            LB=1980;

            if get(handles.checkboxExcludeUSAAfter2000,'Value') == 1

               UB=2000; 

            else

               UB=2004; 
               
            end
            
        elseif strncmp(country,'ISTAT',5)
            LB=YYYYMMDD2Year(20090101);
            UB=YYYYMMDD2Year(20151231);     
        elseif strncmp(country,'FRA2019',7)
            LB=1978;
            UB=2017;        
        elseif strncmp(country,'NLD',7)
            LB=1985.93;
            UB=2016.07;              
        else
            LB=nan(1);
            UB=nan(1);         
        end
        
    end
    
    if get(handles.radiobuttonFilter2DiedBetween,'Value') == 1 && handles.After > 1950

        LB = max(LB,handles.After);

    end

    if get(handles.radiobuttonFilter2DiedBetween,'Value') == 1 && handles.Before < 2050

        UB = min(UB,handles.Before);

    end    
    

function MakeScatterPlot(hObject,handles)

    eps = 0.00000001;

    % Clean up
    set(handles.textN,      'String', '0'); 
    set(handles.textNE,     'String', '0');
    set(handles.textUE,     'String','NaN'); 
    set(handles.textShape,  'String','NaN');
    set(handles.textShapeL, 'String','NaN');
    set(handles.textShapeR, 'String','NaN');
    set(handles.textScale,  'String','NaN');
    set(handles.textScaleL, 'String','NaN');
    set(handles.textScaleR, 'String','NaN');
    set(handles.textScaleE, 'String','NaN');
    set(handles.textScaleEL,'String','NaN');
    set(handles.textScaleER,'String','NaN');   
    set(handles.textLL,     'String','NaN');  
    set(handles.textLLE,    'String','NaN');
    set(handles.textPLS,    'String','NaN');
    set(handles.textP,      'String','NaN');  
   
    I = false(size(handles.data,1),1);
    
    M = strcmp(handles.data(:,5),'M');
    F = strcmp(handles.data(:,5),'F');
    
    E = (cell2mat(handles.data(:,12)) > 0)|(cell2mat(handles.data(:,11)) <= handles.u-0.00001);

    isalive = isnan(YYYYMMDD2Year(cell2mat(handles.data(:,9))));
    
    if  get(handles.radiobuttonPlotAgainstBirth,'Value') == 1
        BD = YYYYMMDD2Year(cell2mat(handles.data(:,8)));
        BA = BD >= handles.After;
        BB = BD <= handles.Before;
    else
        BD = YYYYMMDD2Year(cell2mat(handles.data(:,9)));
        BA = (BD >= handles.After) | (isalive);
        BB = BD <= handles.Before;
        BD(isalive) = YYYYMMDD2Year(cell2mat(handles.data(isalive,8))) + cell2mat(handles.data(isalive,11)) - 0.01;
    end

    VMA = strcmp(handles.data(:,10),'A');
    VMB = strcmp(handles.data(:,10),'B');

    for k = 1:numel(handles.SelectedCountries)
        I = I | strcmp(handles.data(:,7),handles.countries(handles.SelectedCountries(k),2)); 
    end

    if (get(handles.radiobuttonA,'Value') == 1)
        I = I & VMA; 
    elseif (get(handles.radiobuttonB,'Value') == 1)
        I = I & VMB; 
    else

    end

    if sum(I)>0 

        set(handles.TableCountryData, 'Data', handles.data(I,:)); 

        axes(handles.axesScatter);

        cla

        hold off;  
        box on;
        hold on;

        bmin = 2116;
        bmax = 1680;

        if ((get(handles.radiobuttonM,'Value')==1)||(get(handles.radiobuttonMW,'Value')==1))       
            if sum(I&M&(~E)) > 0            
                scatter(BD(I&M&(~E)),cell2mat(handles.data(I&M&(~E),11)),45,'MarkerEdgeColor','b','MarkerFaceColor','r','LineWidth',0.5);
                bmin = min(bmin,min(BD(I&M&(~E)))); 
                bmax = max(bmax,max(BD(I&M&(~E))));
            end
        end

        hold on;

        if ((get(handles.radiobuttonW,'Value')==1)||(get(handles.radiobuttonMW,'Value')==1)) 
            if sum(I&F&(~E)) > 0
                scatter(BD(I&F&(~E)),cell2mat(handles.data(I&F&(~E),11)),45,'MarkerEdgeColor','b','MarkerFaceColor','c','LineWidth',0.5);
            end
            bmin = min(bmin,min(BD(I&F&(~E)))); 
            bmax = max(bmax,max(BD(I&F&(~E))));
        end

        if sum(I&E) > 0
            scatter(BD(I&E),cell2mat(handles.data(I&E,11)),15,'MarkerEdgeColor','k','MarkerFaceColor','k','LineWidth',0.5);
            bmin = min(bmin,min(BD(I&E))); 
            bmax = max(bmax,max(BD(I&E)));        
        end

        ticks = floor(bmin):round((bmax-bmin)/5):ceil(bmax+round((bmax-bmin)/5));

        if isempty(ticks)
           ticks = bmax; 
        end

        set(gca,'XTick',ticks);

        S = I;
        S = S&(~E);

        if (get(handles.radiobuttonM,'Value')==1)  
            S = S&M;
        end

        if (get(handles.radiobuttonW,'Value')==1)  
            S = S&F;
        end    
        
        if get(handles.radiobuttonFilter2DiedBetween,'Value') == 1
            scatter(BD(S&~(BB & BA)),cell2mat(handles.data(S&~(BB & BA),11)),15,'MarkerEdgeColor','k','MarkerFaceColor','k','LineWidth',0.5);
            S = S & BB & BA;
        end
        
        scatter(BD(S&isalive),cell2mat(handles.data(S&isalive,11)),9,'MarkerEdgeColor','g','MarkerFaceColor','r','LineWidth',0.5);

        box on;
        
        if get(handles.radiobuttonPlotAgainstBirth,'Value') == 1
            xlabel 'Year of birth';
        else
            xlabel 'Year of death';
        end
        
        ylabel 'Age';

        x = cell2mat(handles.data(S,11))';

        if ~isempty(x)
      
            EP = nan(1);
            CIEP = [nan(1) nan(1)];
            
            if handles.UnbiasedEstimation == true
                
                DDMin = nan(1,numel(I));
                DDMax = nan(1,numel(I));

                for k = 1:numel(handles.SelectedCountries) 

                    country = handles.countries(handles.SelectedCountries(k),2);          

                    [LB, UB] = CensoringBounds(handles,country);

                    IS = strcmp(handles.data(:,7),country);
                    
                    DDMinObs = nan(1);
                    DDMaxObs = nan(1);
                    
                    if get(handles.radiobuttonFilter2DiedBetween,'Value') == 1 && get(handles.radiobuttonPlotAgainstBirth,'Value') == 0
                        
                       if sum(BA&BB&IS)>0  

                           DDMinObs = min(YYYYMMDD2Year(cell2mat(handles.data(BA&BB&IS,9)))) - eps; 
                           DDMaxObs = max(YYYYMMDD2Year(cell2mat(handles.data(BA&BB&IS,9)))) + eps;
                                                   
                       end
                       
                    else

                       if sum(IS)>0  

                           DDMinObs = min(YYYYMMDD2Year(cell2mat(handles.data(IS,9)))) - eps;
                           DDMaxObs = max(YYYYMMDD2Year(cell2mat(handles.data(IS,9)))) + eps;

                       end

                    end
                    
                    if isnan(LB) 
                        
                        DDMin(IS) = DDMinObs;
                        
                    elseif isnan(DDMinObs)
                        
                        DDMin(IS) = LB;
                        
                    else
                        
                        DDMin(IS) = min(LB,DDMinObs);
                        
                    end

                    if isnan(UB)
                        
                       DDMax(IS) = DDMaxObs;
                       
                    elseif isnan(DDMaxObs)
                        
                       DDMax(IS) = UB;
                       
                    else 
                        
                       DDMax(IS) = max(UB,DDMaxObs);   
                       
                    end
                       
                end      
                
                %clc;
                
                %disp([country{:} ': ' num2str(min(LB,DDMinObs)) ' - ' num2str(max(UB,DDMaxObs))]);
            
                epsilon = 0.0000001;
                
                xi = x - handles.u + epsilon;

                ti = YYYYMMDD2Year(cell2mat(handles.data(S,8)))' + handles.u + epsilon; 

                bi = DDMin(S);
                ei = DDMax(S);

                isbarbi = strncmp(handles.data(S,7),'ISTAT',5)' & (get(handles.radiobuttonFilter2DiedBetween,'Value') ~= 1);
                isalive = isnan(YYYYMMDD2Year(cell2mat(handles.data(S,9)))');
                
                % GPD and Exponential point estimates...
                [par, CI]   = EstimateGPDUnbiased(xi,ti,bi,ei,isbarbi,isalive);
                [parE, CIE] = EstimateExpUnbiased(xi,ti,bi,ei,isbarbi,isalive);
                
                % ...and the corresponding log likelihood values...
                LLGPDV = LLGPDUnbiased(par(1),par(2),xi,ti,bi,ei,isbarbi,isalive);
                LLExpV = LLExpUnbiased(parE(1),xi,ti,bi,ei,isbarbi,isalive);
                
                % ...and confidence interval for the upper endpoint is not
                % computed since it does not make sence
                
                if par(1) < 0
                    
                    EP = handles.u + epsilon - par(2)/par(1);
                    
                end
                

            else
                
                epsilon = 0.0000001;
                
                xi = x - handles.u + epsilon;
                
                % GPD and Exponential point estimates...
                [par,  CI]  =  gpfit(xi);
                [parE, CIE] = expfit(xi);
                
                par = transpose(par);
                CI  = transpose(CI);
                CIE = transpose(CIE);
                
                % ...and the corresponding log likelihood values...
                LLGPDV = LLGPD(par(1),par(2), xi);
                LLExpV = LLExp(parE(1), xi);                
                
                % ...and confidence interval for the upper endpoint,
                % if applicable.
                if (par(1)<0)

                    EP = handles.u - par(2)/par(1);

                    [~,acov] = gplike(par, xi);

                    dh = [par(2)/(par(1)^2) -1/par(1)]';

                    varephat = dh'*acov*dh;

                    if (varephat > epsilon^2)
                        
                        CIEP = EP + norminv(0.975,0,1)*sqrt(varephat)/sqrt(numel(handles.u))*[-1, 1];
                        
                    end
                    
                end

            end
            
            % Compute the p-value
            PLS = 2*(LLGPDV - LLExpV);
            P = 1 - chi2cdf(PLS,1); 
            
            if (handles.MakePOTPlots == true)

                handles.MakePOTPlots = false;
                guidata(hObject,handles); 

                xs = sort(x);

                umin = handles.u;
                umax = xs(end-10) - 0.1;

                u = umin:0.1:umax;

                n = numel(u);

                lambda    = nan(1,n);
                CIExpL    = nan(1,n);
                CIExpU    = nan(1,n);

                gamma         = nan(1,n);
                CIGPDgammaL   = nan(1,n);
                CIGPDgammaU   = nan(1,n);        

                sigma         = nan(1,n);
                CIGPDsigmaL   = nan(1,n);
                CIGPDsigmaU   = nan(1,n);                     

                for i = 1:n

                    xi = x - u(i);

                    I = xi > 0;

                    xi_new = xi(I);
                    
                    if handles.UnbiasedEstimation == true

                        ti_new = ti(I) + u(i) - handles.u; 

                        bi_new = bi(I);
                        ei_new = ei(I);

                        isbarbi_new = isbarbi(I);
                        isalive_new = isalive(I);
                    
                    end

                    try
                        
                        if handles.UnbiasedEstimation == true
                            [parGPD_new, CIGPD_new] = EstimateGPDUnbiased(xi_new,ti_new,bi_new,ei_new,isbarbi_new,isalive_new);
                        else
                            [parGPD_new, CIGPD_new] = gpfit(xi_new + epsilon);
                            
                            parGPD_new = transpose(parGPD_new);
                            CIGPD_new  = transpose(CIGPD_new);
                            
                        end
                         
                    catch 
                        parGPD_new = nan(1,2);
                        CIGPD_new  = nan(2);
                    end

                    try
                        if handles.UnbiasedEstimation == true
                            [parExp_new, CIExp_new] = EstimateExpUnbiased(xi_new,ti_new,bi_new,ei_new,isbarbi_new,isalive_new);
                        else
                            [parExp_new, CIExp_new] = expfit(xi_new + epsilon);
                            CIExp_new  = transpose(CIExp_new);
                        end
                    catch
                        parExp_new = nan(1);
                        CIExp_new  = nan(1,2);
                    end

                    lambda(i) = parExp_new;
                    CIExpU(i) = CIExp_new(1);
                    CIExpL(i) = CIExp_new(2);

                    gamma(i) = parGPD_new(1);
                    CIGPDgammaL(i) = CIGPD_new(1,1);
                    CIGPDgammaU(i) = CIGPD_new(1,2);

                    sigma(i) = parGPD_new(2);
                    CIGPDsigmaL(i) = CIGPD_new(2,1);
                    CIGPDsigmaU(i) = CIGPD_new(2,2);

                end

                figure('position', [0, 0, 1600, 800]);

                subplot(3,1,1);
                plot(u,gamma,'-r');
                xlabel 'u';
                ylabel 'gamma';
                title  'GPD'
                hold on;
                plot(u,CIGPDgammaL,'.-k');
                plot(u,CIGPDgammaU,'.-k');  
                plot([u(1) u(end)], [0 0], ':b');

                subplot(3,1,2);
                plot(u,sigma,'-r');
                xlabel 'u';
                ylabel 'sigma';
                title  'GPD'
                hold on;
                plot(u,CIGPDsigmaL,'.-k');
                plot(u,CIGPDsigmaU,'.-k');    

                subplot(3,1,3);
                plot(u,lambda,'-r');
                xlabel 'u';
                ylabel 'lambda';
                title  'Exponential'
                hold on;
                plot(u,CIExpL,'.-k');
                plot(u,CIExpU,'.-k');                    

            end
            

            %% Display all computed values           
            set(handles.textN,      'String', num2str(numel(x))); 
            set(handles.textN,      'TooltipString', num2str(numel(x))); 
            set(handles.textNE,     'String', num2str(numel(x)));
            set(handles.textNE,     'TooltipString', num2str(numel(x)));
        
            set(handles.textLL,     'String', num2str(LLGPDV));
            
            set(handles.textShape,  'String', num2str(par(1)));
            set(handles.textShapeL, 'String', num2str(CI(1,1)));
            set(handles.textShapeR, 'String', num2str(CI(1,2)));    

            set(handles.textScale,  'String', num2str(par(2)));                        
            set(handles.textScaleL, 'String', num2str(CI(2,1)));
            set(handles.textScaleR, 'String', num2str(CI(2,2)));     
            
            if par(1) < 0
                
                set(handles.textUE,     'String', num2str(EP));         
                set(handles.textUEGPL,  'String', num2str(CIEP(1,1)));
                set(handles.textUEGPR,  'String', num2str(CIEP(1,2)));                
                
            end                        
            
            set(handles.textLLE,    'String', num2str(LLExpV));
            
            set(handles.textScaleE, 'String', num2str(parE(1)));         
            set(handles.textScaleEL,'String', num2str(CIE(1,1)));
            set(handles.textScaleER,'String', num2str(CIE(1,2)));            
            
            set(handles.textPLS,    'String', num2str(PLS));
            set(handles.textP,      'String', num2str(P))
            
           %clc;
            
           %disp([num2str(numel(x)) '   GP: LL ' num2str(LLGPDV) ' Shape ' num2str(par(1)) ' [' num2str(CI(1,1)) ' ' num2str(CI(1,2)) ']']);  
           %disp([num2str(numel(x)) '  Exp: LL ' num2str(LLExpV) ' Scale ' num2str(parE(1)) ' [' num2str(CIE(1,1)) ' ' num2str(CIE(1,2)) ']']);
           %disp(['p-value: ' num2str(P)]);
            
            %% Make PP and QQ plots

            pdExp = makedist('Exponential','mu',parE(1));
            pdGPD = makedist('Generalized Pareto','k',par(1),'sigma',par(2),'theta',0);
     
            axes(handles.axesQQExp);
            
            hold off;
            
            qqplot(x-handles.u,pdExp);
            
            hold on;
           
% THIS CODE PRODUCES FIGURE 5 LEFT FOR USA DATA   
% 
%             N = numel(x);
% 
%             if ((numel(handles.SelectedCountries) == 1) && (strcmp(cell2mat(handles.countries(handles.SelectedCountries(),2)),'USA')))
%                 BirthYear = YYYYMMDD2Year(cell2mat(handles.data(:,8)));
%                 BirthYear = BirthYear(S);
%                 for i = 1:100
%                    DD = zeros(1,N); 
%                    for k = 1:N
%                        for p = 1:100
%                          DD(k) = BirthYear(k)+handles.u+exprnd(parE(1));
%                          if (DD(k) >1980) && (DD(k)<1999) 
%                              break;
%                          end
%                        end
%                    end
%                    y=-log(1 - ((1:N) - 0.5)/N)*parE(1);
%                    Z=sort(DD-BirthYear'-handles.u);
%                    plot(y,Z,':k');
%                 end
%                 
%             end
%
% <---------------------------------------END 

            box on;
            
            title '';
            xlabel 'Quantile (Exponential)';
            ylabel 'Observed quantile';
                      
            axes(handles.axesPPExp);

            probplot(pdExp,x-handles.u);
            
            box on;
            
            title '';
            xlabel 'Data (Exponential)';
            ylabel 'Observed probability';                   

            axes(handles.axesQQGPD);

            sample_GPD = x-handles.u;
            %sample_GPD(1+pdGPD.k/pdGPD.sigma*sample_GPD <= 0) = [];
            
            qqplot(sample_GPD,pdGPD);
            
            box on;
            
            title '';
            xlabel 'Quantile (GPD)';
            ylabel 'Observed quantile';

            axes(handles.axesPPGPD);

            probplot(pdGPD,sample_GPD);
            
            box on;
            
            title '';
            xlabel 'Data (GPD)';
            ylabel 'Observed probability';            

        else
            
            set(handles.textN,'String', '0');
            set(handles.textNE,'String', '0');
            set(handles.textUE,'String','NaN'); 
            set(handles.textShape,'String','NaN');
            set(handles.textShapeL,'String', 'NaN');
            set(handles.textShapeR,'String','NaN');
            set(handles.textScale,'String','NaN');
            set(handles.textScaleL,'String','NaN');
            set(handles.textScaleR,'String', 'NaN');
            set(handles.textScaleE,'String', 'NaN');
            set(handles.textScaleEL,'String','NaN');
            set(handles.textScaleER,'String','NaN');
            set(handles.textLLE,'String', 'NaN')        
            set(handles.textLL,'String', 'NaN');  
            set(handles.textLLE,'String', 'NaN');
            set(handles.textPLS,'String','NaN');
            set(handles.textP,'String', 'NaN');    
            
        end

        handles.x = x;
        handles.S = S;
        
        guidata(hObject, handles);

    else
        
        handles.S = false(size(handles.data,1),1);
               
        cla;
        
    end

function SimulateBias(handles,Country)

    if strcmp(Country,'USA')
       I = strcmp(handles.data(:,7),'USA')&(handles.S); 
       I = I & (cell2mat(handles.data(:,9))'/10000 < 2000)';
       if sum(I) == 0
          waitfor(msgbox('Please select at least one individual from USA', 'Empty data set','error')); 
       end       
    elseif strcmp(Country,'FRA')
       I = strcmp(handles.data(:,7),'FRA')&(handles.S);     
       if sum(I) == 0
          waitfor(msgbox('Please select at least one individual from FRA', 'Empty data set','error')); 
       end
    elseif strcmp(Country,'GBR')
       I = strcmp(handles.data(:,7),'GBR')&(handles.S);
       if sum(I) == 0
          waitfor(msgbox('Please select at least one individual from GBR', 'Empty data set','error')); 
       end             
    else
       return;         
    end

    BirthDate = floor(cell2mat(handles.data(I,8))'/10000);
    DeathDate = floor(cell2mat(handles.data(I,9))'/10000);
    LB = min(DeathDate);
    UB = max(DeathDate);    
    
    N = sum(I);  
    
    NSimulations = 10000;
    
    r = 0.5:0.1:2;
    K = numel(r);
    
    Biases = nan(1,K);
    Stds = nan(1,K);

    for j = 1:K
        
        MuUnbiased = r(j);
    
        Bias = nan(1,NSimulations);
        for i = 1:NSimulations
            DeathDateSimulated = BirthDate + 110 + exprnd(MuUnbiased,1,N);
            x =  DeathDateSimulated-BirthDate;
            I = (DeathDateSimulated>=LB)&(DeathDateSimulated<=UB); 
            [parE, ~] = expfit(x(I)-handles.u+0.00001);
            Bias(i) = parE - MuUnbiased;
        end

        Biases(j) = nanmean(Bias);
        Stds(j) = nanstd(Bias);

    end
    
     figure()
     plot(r+Biases,100*Biases./r);
     hold on;
     plot(r+Biases, 100*(Biases+Stds/sqrt(NSimulations))./r,'-r');
     plot(r+Biases, 100*(Biases-Stds/sqrt(NSimulations))./r,'-r');
     set(gca,'XLim',[0.5 1.6]);
     box on;
     xlabel('$\hat{\sigma}$','Interpreter','LaTex','FontSize',15);
     ylabel('$(\hat{\sigma}-\sigma)/\sigma\times 100\%$','Interpreter','LaTex','FontSize',15);

    %This should be unbiased, just checking...
    Bias = nan(1,NSimulations);
    
    BDMin = min(floor(cell2mat(handles.data(I,8))'/10000));
    BDMax = max(floor(cell2mat(handles.data(I,8))'/10000));
    
    Biases = nan(1,numel(LB:UB));
    Stds   = nan(1,numel(LB:UB));
    
    for k = (LB-10):(UB-1)
        for i = 1:NSimulations  
            BirthDate = BDMin + (BDMax-BDMin)*rand(1,N);
            DeathDateSimulated = BirthDate + 110 + exprnd(MuUnbiased,1,N);
            x =  DeathDateSimulated-BirthDate;
            I = (DeathDateSimulated<UB)&(DeathDateSimulated>k);
            [parE, ~] = expfit(x(I)-handles.u+0.00001);
            Bias(i) = parE - MuUnbiased;
        end
        Biases(k-LB+11) = nanmean(Bias);
        Stds(k-LB+11) = nanstd(Bias);
    end
   
    disp(['Bias, simulated birth years, mean:' num2str(nanmean(Bias))]);
    disp(['Bias, simulated birth years, std:' num2str(nanstd(Bias))]);

    figure('Name','Bias, simulated birth years');
    plot((LB-10):(UB-1),Biases);
    hold on;
    plot((LB-10):(UB-1),Biases+Stds/sqrt(10000),'-r');
    plot((LB-10):(UB-1),Biases-Stds/sqrt(10000),'-r');
    xlabel 'k';
    ylabel 'Bias';

% --- Executes on button press in pushbuttonSave.
function pushbuttonSave_Callback(~, ~, handles) 
    data = handles.data; %#ok<NASGU>
    save('data.mat','data');

% --- Executes when entered data in editable cell(s) in TableCountryData.
function TableCountryData_CellEditCallback(hObject, eventdata, handles) 

    tableData = get(handles.TableCountryData, 'data');
    
    ID = tableData{eventdata.Indices(1),1};
    
    if isempty(eventdata.NewData)
        handles.data(cell2mat(handles.data(:,1))==ID,12) = {eventdata.PreviousData};
    else
        handles.data(cell2mat(handles.data(:,1))==ID,12) = {eventdata.NewData};
    end

    guidata(hObject, handles);

    I = cell2mat(handles.data(:,1));
    V = sum(cell2mat(handles.data(I==584,12)));
    
    if abs(V - get(handles.checkboxJC,'Value')) ~= 1
        set(handles.checkboxJC,'Value',~V);
        checkboxJC_Callback(hObject, [], handles);
        return;
    end

    MakeScatterPlot(hObject,handles);

% --- Executes when selected object is changed in uipanel4.
function uipanel4_SelectionChangeFcn(hObject, ~, handles) 
    MakeScatterPlot(hObject,handles);

% --- Executes on button press in pushbuttonDFitTool.
function pushbuttonDFitTool_Callback(~, ~, handles) 
    dfittool(handles.x(handles.x>=handles.u)-handles.u+0.00001);

function editFilter2Before_Callback(hObject, ~, handles) 
    handles.Before = str2double(get(hObject,'String'));
    guidata(hObject, handles);
    if get(handles.radiobuttonFilter2DiedBetween,'Value') == 1
        MakeScatterPlot(hObject,handles);
    end

function editFilter2After_Callback(hObject, ~, handles) 

    handles.After = str2double(get(hObject,'String'));
    guidata(hObject, handles);
    
    if get(handles.radiobuttonFilter2DiedBetween,'Value') == 1
        MakeScatterPlot(hObject,handles);
    end

% --- Executes when selected object is changed in uipanelFilter2.
function uipanelFilter2_SelectionChangeFcn(hObject, ~, handles) 
    MakeScatterPlot(hObject,handles);

% --- Executes when selected object is changed in uipanel6.
function uipanel6_SelectionChangeFcn(hObject, ~, handles) 
    MakeScatterPlot(hObject,handles);

% --- Executes on button press in checkboxJC.
function checkboxJC_Callback(hObject, ~, handles)

    if get(handles.checkboxJC,'Value')
        axes(handles.axesLogo);
        cla;
        I = imread('logo.jpg');
        imagesc(I)
        set(gca,'XTick',[]);
        set(gca,'YTick',[]);
        box on;
        I  = cell2mat(handles.data(:,1))==584;
        handles.data{I,12}=0;
    else
        axes(handles.axesLogo);
        hold on;
        tmp1 = get(gca,'XLim');
        tmp2 = get(gca,'YLim');
        plot([tmp1(1) tmp1(2)],[tmp2(1) tmp2(2)],'-k','LineWidth',3);
        plot([tmp1(1) tmp1(2)],[tmp2(2) tmp2(1)],'-k','LineWidth',3);
        I  = cell2mat(handles.data(:,1))==584;
        handles.data{I,12}=1;
    end

    guidata(hObject, handles);

    MakeScatterPlot(hObject,handles);

% --- Executes when selected object is changed in uipanelPlotAgainst.
function uipanelPlotAgainst_SelectionChangeFcn(hObject, ~, handles) 

    if get(handles.radiobuttonPlotAgainstBirth,'Value')
        set(handles.uipanelFilter2,'Title','Filter 2: Birth Date');
        set(handles.radiobuttonFilter2DiedBetween,'String','Born between');
    else
        set(handles.uipanelFilter2,'Title','Filter 2: Death Date');
        set(handles.radiobuttonFilter2DiedBetween,'String','Died between');
    end

    handles.Before = 2100;
    handles.After = 1800;
    set(handles.editFilter2Before,'String','2100');
    set(handles.editFilter2After,'String','1800');

    set(handles.radiobuttonFilter2All,'Value',1);

    guidata(hObject, handles);

    MakeScatterPlot(hObject,handles);

% --- Executes on button press in checkboxExcludeUSAAfter2000.
function checkboxExcludeUSAAfter2000_Callback(hObject, ~, handles) 

    Died = cell2mat(handles.data(:,9));
    I = strcmp(handles.data(:,7),'USA')&(Died>=20000101); 
    handles.data(I,12) = {get(hObject,'Value')};
    guidata(hObject, handles);

    MakeScatterPlot(hObject,handles);

% --- Executes on button press in checkboxExcludeJapanAfter2000.
function checkboxExcludeJapanAfter2000_Callback(hObject, ~, handles) 

    Died = cell2mat(handles.data(:,9));
    I = strcmp(handles.data(:,7),'JPN')&(Died>=20040901); 
    handles.data(I,12) = {get(hObject,'Value')};
    guidata(hObject, handles);

    MakeScatterPlot(hObject,handles);

function editThreshold_Callback(hObject, ~, handles) 

    handles.u = str2double(get(hObject,'String'));
    guidata(hObject, handles);
    MakeScatterPlot(hObject,handles);

% --- Executes on button press in pushbuttonDeattachScatterMain.
function pushbuttonDeattachScatterMain_Callback(~, ~, handles) 

    pos = get(handles.figureGUI,'Position');
    figure('Name','Deattached Plot (main plot)','Units','Centimeters','Position',[(pos(1)+pos(3)/2 -8),    (pos(2)+pos(4)/2 -8),    16,    16],...
           'NumberTitle','off');
    h=copyobj(handles.axesScatter,gcf);
    set(h,'Units','Normalized');
    set(h,'Position',[0.1,0.1,0.8,0.8]);

% --- Executes on button press in pushbuttonDeattachPPE.
function pushbuttonDeattachPPE_Callback(~, ~, handles) 

    pos = get(handles.figureGUI,'Position');
    figure('Name','Deattached Plot (pp plot, Exponential)','Units','Centimeters','Position',[(pos(1)+pos(3)/2 -8),    (pos(2)+pos(4)/2 -8),    16,    16],...
           'NumberTitle','off');
    h=copyobj(handles.axesPPExp,gcf);
    set(h,'Units','Normalized');
    set(h,'Position',[0.1,0.1,0.8,0.8]);

% --- Executes on button press in pushbuttonDeattachQQE.
function pushbuttonDeattachQQE_Callback(~, ~, handles) 

    pos = get(handles.figureGUI,'Position');
    figure('Name','Deattached Plot (qq plot, Exponential)','Units','Centimeters','Position',[(pos(1)+pos(3)/2 -8),    (pos(2)+pos(4)/2 -8),    16,    16],...
           'NumberTitle','off');
    h=copyobj(handles.axesQQExp,gcf);
    set(h,'Units','Normalized');
    set(h,'Position',[0.1,0.1,0.8,0.8]);

% --- Executes on button press in pushbuttonDeattachPPGPD.
function pushbuttonDeattachPPGPD_Callback(~, ~, handles) 

    pos = get(handles.figureGUI,'Position');
    figure('Name','Deattached Plot (pp plot, GPD)','Units','Centimeters','Position',[(pos(1)+pos(3)/2 -8),    (pos(2)+pos(4)/2 -8),    16,    16],...
           'NumberTitle','off');
    h=copyobj(handles.axesPPGPD,gcf);
    set(h,'Units','Normalized');
    set(h,'Position',[0.1,0.1,0.8,0.8]);

% --- Executes on button press in pushbuttonDeattachQQGPD.
function pushbuttonDeattachQQGPD_Callback(~, ~, handles) 

    pos = get(handles.figureGUI,'Position');
    figure('Name','Deattached Plot (qq plot, GPD)','Units','Centimeters','Position',[(pos(1)+pos(3)/2 -8),    (pos(2)+pos(4)/2 -8),    16,    16],...
           'NumberTitle','off');
    h=copyobj(handles.axesQQGPD,gcf);
    set(h,'Units','Normalized');
    set(h,'Position',[0.1,0.1,0.8,0.8]);

% --- Executes on button press in pushbuttonKSTest.
function pushbuttonKSTest_Callback(~, ~, handles) 

    [parE, ~] = expfit(handles.x-handles.u+0.00001);
    x = sort(handles.x-handles.u+0.00001); 
    n=numel(x);
    Sx=(1:n)/n;
    Fx=1-exp(-x/parE);
    Dn=max(abs(Sx-Fx));
    [pvalue, CriticalValue]=KSCDF(Dn,n,0.05);
%   CriticalValue = 1.06/sqrt(n);
    pvalue=1-pvalue;
    H=(pvalue<0.05);
    if H
           uiwait(msgbox(['Null hypothesis that the sample '...
                   ' is drawn from'... 
                   ' exponential distribution is rejected at '... 
                   num2str(0.05) ' significance level,'...
                   ' p-value: ' num2str(pvalue) '.' ' Estimated rate =' num2str(parE) '.']));
    else
           uiwait(msgbox(['Null hypothesis that the sample '...
                   ' is drawn from'...     
                   ' exponential distribution can not be rejected at '... 
                   num2str(0.05) ' significance level,'...
                   ' p-value: ' num2str(pvalue) '.' ' Estimated rate =' num2str(parE) '.']));        
    end
    FxCIL=Fx-CriticalValue;
    FxCIU=Fx+CriticalValue;        
    figure('Name','K.-S. Godness of Fit Test (exponential distribution, parameter unknown)');
    plot(Fx,Sx,'Color','k');
    hold on;
    plot(Fx,Fx,'Color','r');
    plot(Fx,FxCIU,'Color','r','LineStyle',':');
    plot(Fx,FxCIL,'Color','r','LineStyle',':');
    set(gca,'XLim',[0 1]);
    set(gca,'YLim',[0 1]);    
    title(['K.-S. Godness of Fit Test (exponential distribution, parameter unknown). ' '\alpha=' num2str(0.05)]);
    xlabel('x');
    ylabel('CDF(x)');
    text(0.05,0.95,['P-value: ' num2str(pvalue) '.']);
    set(gca,'PlotBoxAspectRatio',[1 1 1]);   

% --- Executes on button press in pushbuttonSimulateBiasUSA.
function pushbuttonSimulateBiasUSA_Callback(~, ~, handles) 
    SimulateBias(handles,'USA');

% --- Executes on button press in pushbuttonPoissonRegression.
function pushbuttonPoissonRegression_Callback(~, ~, handles) 

    I = false(size(handles.data,1),1);
    M = strcmp(handles.data(:,5),'M');
    F = strcmp(handles.data(:,5),'F');
    E = (cell2mat(handles.data(:,12)) > 0)|(cell2mat(handles.data(:,11))<=handles.u-0.00001);

    if get(handles.radiobuttonPlotAgainstBirth,'Value') == 1
        BirthOrDeathColumn = 8;
    else
        BirthOrDeathColumn = 9;
    end

    BD = YYYYMMDD2Year(cell2mat(handles.data(:,BirthOrDeathColumn)));
    BB = BD <= handles.Before;
    BA = BD >= handles.After;

    VMA = strcmp(handles.data(:,10),'A');
    VMB = strcmp(handles.data(:,10),'B');

    for k = 1:numel(handles.SelectedCountries)
       I = I | strcmp(handles.data(:,7),handles.countries(handles.SelectedCountries(k),2)); 
    end

    if (get(handles.radiobuttonA,'Value')==1)
       I = I & VMA; 
    elseif (get(handles.radiobuttonB,'Value')==1)
       I = I & VMB; 
    else

    end

    if sum(I)>0 

        S = I;
        S = S&(~E);

        if (get(handles.radiobuttonM,'Value')==1)  
            S = S&M;
        end

        if (get(handles.radiobuttonW,'Value')==1)  
            S = S&F;
        end    

        if get(handles.radiobuttonFilter2DiedBetween,'Value') == 1
            S = S&BA&BB;      
        end

        if get(handles.radiobuttonPoisson110Birthday,'Value') == 1 
            x = floor(YYYYMMDD2Year(cell2mat(handles.data(S,8))')) + 110;
        else
            x = floor(YYYYMMDD2Year(cell2mat(handles.data(S,9))'));
        end

        xu = sort(unique(x));
        yu = nan(1,numel(xu));

        for i=1:numel(xu)
            yu(i) = sum(x==xu(i));
        end

        I=(xu>=handles.PoissonFrom)&(xu<=handles.PoissonTo);
        xu=xu(I)-handles.PoissonFrom;
        yu=yu(I);  

        figure('Name',['Poisson Regression (' num2str(handles.PoissonFrom) '-' num2str(handles.PoissonTo) ')']);
        plot(handles.PoissonFrom + xu,yu,'*b');
        if get(handles.radiobuttonPoisson110Birthday,'Value') == 1 
            xlabel('Year of 110th birthday');
        else
            xlabel('Year of death');
        end
        ylabel('Number of supercentenarians');
        hold on;
        box on; 
        
        set(gca,'XLim',[handles.PoissonFrom + min(xu)-1 handles.PoissonFrom + max(xu)+1]);
        set(gca,'YLim',[0 max(yu)+1]);

        DFrom = 2018;
        DTo = 2042;

        if get(handles.checkboxLogLink,'Value')==1
            
            [b,~,stats]=glmfit(xu,yu,'poisson','link','log');
            
            title(['mu=exp(' num2str(b(1)) '+' num2str(b(2)) '*x)']);
            plot(handles.PoissonFrom + xu,exp(b(1)+xu*b(2)),'-r','LineWidth',2);
            
            CIL = zeros(1,numel(xu));
            CIU = zeros(1,numel(xu));
            
            for i = 1:numel(xu)
                delta = exp(b(1))*[exp(xu(i)*b(2)) xu(i).*exp(xu(i)*b(2))];
                var_est = delta*stats.covb*delta';
                CIL(i) = exp(b(1)+xu(i)*b(2)) - sqrt(var_est)*norminv(0.975+0.0125,0,1);
                CIU(i) = exp(b(1)+xu(i)*b(2)) + sqrt(var_est)*norminv(0.975+0.0125,0,1);            
            end
            
            plot(handles.PoissonFrom + xu,CIL,':k','LineWidth',1);
            plot(handles.PoissonFrom + xu,CIU,':k','LineWidth',1);            
            
            estFromTo = sum(exp(b(1)+((DFrom:DTo)-handles.PoissonFrom)*b(2)));
            
        else
            
            [b,~,stats]=glmfit(xu,yu,'poisson','link','identity');
            
            title(['mu=' num2str(b(1)) '+' num2str(b(2)) '*x']);
            plot(handles.PoissonFrom + xu,b(1)+xu*b(2),'-r','LineWidth',2);
            
            var_est = stats.covb(1,1)+xu.^2*stats.covb(2,2)+2*xu*stats.covb(1,2);
            
            CIL = b(1)+xu*b(2) - sqrt(var_est)*norminv(0.975+0.0125,0,1);
            CIU = b(1)+xu*b(2) + sqrt(var_est)*norminv(0.975+0.0125,0,1);
            
            plot(handles.PoissonFrom + xu,CIL,':k','LineWidth',1);
            plot(handles.PoissonFrom + xu,CIU,':k','LineWidth',1);
            
            estFromTo = sum(b(1)+((DFrom:DTo)-handles.PoissonFrom)*b(2));
            
        end

        disp('Poisson regression results:');
        disp(' ');

        disp('Var(b1):');
        disp(stats.covb(1,1));

        disp('Var(b2):');
        disp(stats.covb(2,2));  

        disp('Cov(b1,b2):');
        disp(stats.covb(1,2));   

        if get(handles.radiobuttonPoisson110Birthday,'Value') == 1 
            disp(['Estimated number of people who will turn 110 between ' num2str(DFrom) ' and ' num2str(DTo) ':']);
        else
            disp(['Estimated number of people of age >= 110 who will die between ' num2str(DFrom) ' and ' num2str(DTo) ':']);
        end

        disp(estFromTo);

        if get(handles.checkboxLogLink,'Value')==0
            a1 = (DTo-DFrom+1);
            a2 = sum(DFrom:DTo) - (DTo-DFrom+1)*handles.PoissonFrom;
            var_est = a1^2*stats.covb(1,1)+a2^2*stats.covb(2,2)+2*a1*a2*stats.covb(1,2);
            CIL = estFromTo - sqrt(var_est)*norminv(0.975+0.0125,0,1);
            CIU = estFromTo + sqrt(var_est)*norminv(0.975+0.0125,0,1);
            disp(['97.5% confidence interval: (' num2str(CIL) ',' num2str(CIU) ')']);
        else
            delta = exp(b(1))*[sum(exp(((DFrom:DTo)-handles.PoissonFrom)*b(2))) sum(((DFrom:DTo)-handles.PoissonFrom).*exp(((DFrom:DTo)-handles.PoissonFrom)*b(2)))];
            var_est = delta*stats.covb*delta';
            CIL = estFromTo - sqrt(var_est)*norminv(0.975+0.0125,0,1);
            CIU = estFromTo + sqrt(var_est)*norminv(0.975+0.0125,0,1);
            disp(['97.5% confidence interval (delta method): (' num2str(CIL) ',' num2str(CIU) ')']);    

            b1CIL = b(1) - sqrt(stats.covb(1,1))*norminv(sqrt(0.975),0,1);
            b1CIU = b(1) + sqrt(stats.covb(1,1))*norminv(sqrt(0.975),0,1);

            b2CIL = b(2) - sqrt(stats.covb(2,2))*norminv(sqrt(0.975),0,1);
            b2CIU = b(2) + sqrt(stats.covb(2,2))*norminv(sqrt(0.975),0,1);

            estLow  = sum(exp(b1CIL+((DFrom:DTo)-handles.PoissonFrom)*b2CIL));
            estHigh = sum(exp(b1CIU+((DFrom:DTo)-handles.PoissonFrom)*b2CIU));

            disp(['97.5% confidence interval (conservative): (' num2str(estLow) ',' num2str(estHigh) ')']);         

            N=10000;
            b = mvnrnd(stats.beta,stats.covb,N);
            est = zeros(1,N);
            for i=1:N
                est(i) = sum(exp(b(i,1)+((DFrom:DTo)-handles.PoissonFrom)*b(i,2)));
            end

            CIL = quantile(est,0.0125);
            CIU = quantile(est,0.975+0.0125);
            disp(['97.5% confidence interval (simulation): (' num2str(CIL) ',' num2str(CIU) ')']);  

        end

    else
        waitfor(msgbox('Selected sample is empty','LATool, Poisson Regression'));
    end

% --- Executes on button press in checkboxLogLink.
function checkboxLogLink_Callback(hObject, eventdata, handles) %#ok<*DEFNU,*INUSD>

function editPoissonFrom_Callback(hObject, eventdata, handles) %#ok<*INUSL>

    handles.PoissonFrom = str2double(get(hObject,'String'));
    guidata(hObject, handles);

function editPoissonTo_Callback(hObject, eventdata, handles)

    handles.PoissonTo = str2double(get(hObject,'String'));
    guidata(hObject, handles);

% --- Executes on button press in pushbuttonDoCrap.
function pushbuttonDoCrap_Callback(hObject, eventdata, handles)

    years = sort(unique(floor(cell2mat(handles.data(handles.S,9))'/10000)));
    N = numel(years);
    MaxAgeReported = nan(1,N);
    NObs = nan(1,N);

    for i = 1:N
        MaxAgeReported(i) = floor(max(cell2mat(handles.data(handles.S&(floor(cell2mat(handles.data(:,9))/10000) == years(i)),11))));
        NObs(i) = numel(cell2mat(handles.data(handles.S&(floor(cell2mat(handles.data(:,9))/10000) == years(i)),11)));
    end
    figure('Position', [635   425   680   320]);

    x = years(years<handles.CrapThreshold);
    y = MaxAgeReported(years<handles.CrapThreshold);

    if numel(x) > 0

        scatter(x,y,45,'MarkerEdgeColor','b','MarkerFaceColor','c','LineWidth',0.5);
        hold on;
        [P, ~] = polyfit(x,y,1);

        if (P(2)>0)
            text(min(years)+1,122,['y=' num2str(P(1)) 'x+' num2str(P(2))] ,'Interpreter','LaTex');
        else
            text(min(years)+1,122,['y=' num2str(P(1)) 'x' num2str(P(2))] ,'Interpreter','LaTex');
        end

        yfit = P(1)*x+P(2);
        plot(x,yfit,'b-.','LineWidth',2);

    end

    x = years(years>handles.CrapThreshold);
    y = MaxAgeReported(years>handles.CrapThreshold);

    if numel(x) > 0

        scatter(x,y,45,'MarkerEdgeColor','b','MarkerFaceColor','r','LineWidth',0.5);
        hold on;
        [P, ~] = polyfit(x,y,1);
        if (P(2)>0)
            text(min(years)+1,121,['y=' num2str(P(1)) 'x+' num2str(P(2))] ,'Interpreter','LaTex');
        else
            text(min(years)+1,121,['y=' num2str(P(1)) 'x' num2str(P(2))] ,'Interpreter','LaTex');
        end
        yfit = P(1)*x+P(2);
        plot(x,yfit,'r-.','LineWidth',2);

    end

    set(gca,'YLim',[108 124]);

    ylabel 'Yearly maximum reported age at death (years)';
    xlabel 'Year';

    ax1 = gca;
    ax2 = axes('Position',get(ax1,'Position'),...
           'XAxisLocation','top',...
           'XTickLabel',[],...
           'XTick',[],...
           'YAxisLocation','right',...
           'YLim',[0 max(NObs)+1],...
           'Color','none',...
           'XColor','k','YColor','k');
       
    %linkaxes([ax1 ax2],'x');
    
    hold on
    plot(years,NObs,'--k','LineWidth',2,'Parent',ax2);
    ylabel 'Number of deaths';

function editCrapThreshold_Callback(hObject, eventdata, handles)

    handles.CrapThreshold = str2double(get(hObject,'String'));
    guidata(hObject,handles);

% --- Executes on button press in pushbuttonSimulateBiasFrance.
function pushbuttonSimulateBiasFrance_Callback(hObject, eventdata, handles)
    SimulateBias(handles,'FRA');

% --- Executes on button press in pushbuttonSimulateBiasUK.
function pushbuttonSimulateBiasUK_Callback(hObject, eventdata, handles)
    SimulateBias(handles,'GBR');

% --- Executes when selected object is changed in uipanelEstimationMethod.
function uipanelEstimationMethod_SelectionChangeFcn(hObject, eventdata, handles)

    if get(handles.radiobuttonEstimationUnbiased,'Value') == 1
       handles.UnbiasedEstimation = true; 
    else
       handles.UnbiasedEstimation = false;
    end
    
    guidata(hObject,handles);
    MakeScatterPlot(hObject,handles);
    

% --- Executes on button press in pushbuttonPOT.
function pushbuttonPOT_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonPOT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.MakePOTPlots = true;  
guidata(hObject,handles);
MakeScatterPlot(hObject,handles);
    
% --- Executes on button press in textPaperLink.
function textPaperLink_Callback(hObject, eventdata, handles)
% hObject    handle to textPaperLink (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('https://github.com/OGCJN/Human-life-is-unlimited---but-short');


    % --- Executes during object creation, after setting all properties.
function editFilter2Before_CreateFcn(hObject, ~, ~) 

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
% --- Executes during object creation, after setting all properties.
function editFilter2After_CreateFcn(hObject, ~, ~) 

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
% --- Executes during object creation, after setting all properties.
function editThreshold_CreateFcn(hObject, ~, ~) 

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end    
    
% --- Executes during object creation, after setting all properties.
function editPoissonFrom_CreateFcn(hObject, eventdata, handles)

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end    
    
% --- Executes during object creation, after setting all properties.
function editPoissonTo_CreateFcn(hObject, eventdata, handles)

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end    
    
% --- Executes during object creation, after setting all properties.
function editCrapThreshold_CreateFcn(hObject, eventdata, handles)

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end



%% DISCLAIMER
% What follows is a third-party code which is used to estimate Hessian of the log-likelihood.
% One should not use MATLAB native algorithm "fmincon" to compute Hessian because such    
% estimates lack precsision and give unsatisfactory results.
%
% Use the code below, which is a modified version of the code downloaded from
% http://www.mathworks.com/matlabcentral/fileexchange/13490-adaptive-robust-numerical-differentiation
% or implement a hessian estimation routine of your own. 
% The third party code was provided under BSD Licence, see below.


% Copyright (c) 2007, John D'Errico
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are
% met:
% 
%     * Redistributions of source code must retain the above copyright
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright
%       notice, this list of conditions and the following disclaimer in
%       the documentation and/or other materials provided with the distribution
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE.

%%
function [hess,err] = hessian(fun,x0)
% hessian: estimate elements of the Hessian matrix (array of 2nd partials)
% usage: [hess,err] = hessian(fun,x0)
%
% Hessian is NOT a tool for frequent use on an expensive
% to evaluate objective function, especially in a large
% number of dimensions. Its computation will use roughly
% O(6*n^2) function evaluations for n parameters.
% 
% arguments: (input)
%  fun - SCALAR analytical function to differentiate.
%        fun must be a function of the vector or array x0.
%        fun does not need to be vectorized.
% 
%  x0  - vector location at which to compute the Hessian.
%
% arguments: (output)
%  hess - nxn symmetric array of second partial derivatives
%        of fun, evaluated at x0.
%
%  err - nxn array of error estimates corresponding to
%        each second partial derivative in hess.
%
%
% Example usage:
%  Rosenbrock function, minimized at [1,1]
%  rosen = @(x) (1-x(1)).^2 + 105*(x(2)-x(1).^2).^2;
%  
%  [h,err] = hessian(rosen,[1 1])
%  h =
%           842         -420
%          -420          210
%  err =
%    1.0662e-12   4.0061e-10
%    4.0061e-10   2.6654e-13
%
%
% Example usage:
%  cos(x-y), at (0,0)
%  Note: this hessian matrix will be positive semi-definite
%
%  hessian(@(xy) cos(xy(1)-xy(2)),[0 0])
%  ans =
%           -1            1
%            1           -1
%
%
% See also: derivest, gradient, gradest, hessdiag
%
%
% Author: John D'Errico
% Release: 1.0
% Release date: 2/10/2007

% parameters that we might allow to change.
params.StepRatio = 2.0000001;
params.RombergTerms = 3;

% get the size of x0 so we can reshape later.
sx = size(x0);

% was a string supplied?
if ischar(fun)
  fun = str2func(fun);
end

% total number of derivatives we will need to take
nx = length(x0);

% get the diagonal elements of the hessian (2nd partial
% derivatives wrt each variable).
[hess,err] = hessdiag(fun,x0);

% form the eventual hessian matrix, stuffing only
% the diagonals for now.
hess = diag(hess);
err = diag(err);
if nx<2
  % the hessian matrix is 1x1. all done.
  return
end

% get the gradient vector. This is done only to decide
% on intelligent step sizes for the mixed partials.
[~,~,stepsize] = gradest(fun,x0);

% get params. RombergTerms+1 estimates of the upper
% triangle of the hessian matrix.
dfac = params.StepRatio.^(-(0:params.RombergTerms)');
for i = 2:nx
  for j = 1:(i-1)
    dij = zeros(params.RombergTerms+1,1);
    for k = 1:(params.RombergTerms+1)
      dij(k) = fun(x0 + swap2(zeros(sx),i, ...
        dfac(k)*stepsize(i),j,dfac(k)*stepsize(j))) + ...
        fun(x0 + swap2(zeros(sx),i, ...
        -dfac(k)*stepsize(i),j,-dfac(k)*stepsize(j))) - ...
        fun(x0 + swap2(zeros(sx),i, ...
        dfac(k)*stepsize(i),j,-dfac(k)*stepsize(j))) - ...
        fun(x0 + swap2(zeros(sx),i, ...
        -dfac(k)*stepsize(i),j,dfac(k)*stepsize(j)));
        
    end
    dij = dij/4/prod(stepsize([i,j]));
    dij = dij./(dfac.^2);
    
    % Romberg extrapolation step.
    [hess(i,j),err(i,j)] =  rombextrap(params.StepRatio,dij,[2 4]);
    hess(j,i) = hess(i,j);
    err(j,i) = err(i,j);
  end
end


%%
function [HD,err,finaldelta] = hessdiag(fun,x0)
% HESSDIAG: diagonal elements of the Hessian matrix (vector of second partials)
% usage: [HD,err,finaldelta] = hessdiag(fun,x0)
%
% When all that you want are the diagonal elements of the hessian
% matrix, it will be more efficient to call HESSDIAG than HESSIAN.
% HESSDIAG uses DERIVEST to provide both second derivative estimates
% and error estimates. fun needs not be vectorized.
% 
% arguments: (input)
%  fun - SCALAR analytical function to differentiate.
%        fun must be a function of the vector or array x0.
% 
%  x0  - vector location at which to differentiate fun
%        If x0 is an nxm array, then fun is assumed to be
%        a function of n*m variables. 
%
% arguments: (output)
%  HD  - vector of second partial derivatives of fun.
%        These are the diagonal elements of the Hessian
%        matrix, evaluated at x0.
%        HD will be a row vector of length numel(x0).
%
%  err - vector of error estimates corresponding to
%        each second partial derivative in HD.
%
%  finaldelta - vector of final step sizes chosen for
%        each second partial derivative.
%
%
% Example usage:
%  [HD,err] = hessdiag(@(x) x(1) + x(2)^2 + x(3)^3,[1 2 3])
%  HD =
%     0     2    18
%
%  err =
%     0     0     0
%
%
% See also: derivest, gradient, gradest
%
%
% Author: John D'Errico
% Release: 1.0
% Release date: 2/9/2007

% total number of derivatives we will need to take
nx = numel(x0);

HD = zeros(1,nx);
err = HD;
finaldelta = HD;
for ind = 1:nx
  [HD(ind),err(ind),finaldelta(ind)] = derivest( ...
    @(xi) fun(swapelement(x0,ind,xi)), ...
    x0(ind),'deriv',2,'vectorized','no');
end

%%
function [grad,err,finaldelta] = gradest(fun,x0)
% gradest: estimate of the gradient vector of an analytical function of n variables
% usage: [grad,err,finaldelta] = gradest(fun,x0)
%
% Uses derivest to provide both derivative estimates
% and error estimates. fun needs not be vectorized.
% 
% arguments: (input)
%  fun - analytical function to differentiate. fun must
%        be a function of the vector or array x0.
% 
%  x0  - vector location at which to differentiate fun
%        If x0 is an nxm array, then fun is assumed to be
%        a function of n*m variables. 
%
% arguments: (output)
%  grad - vector of first partial derivatives of fun.
%        grad will be a row vector of length numel(x0).
%
%  err - vector of error estimates corresponding to
%        each partial derivative in grad.
%
%  finaldelta - vector of final step sizes chosen for
%        each partial derivative.
%
%
% Example:
%  [grad,err] = gradest(@(x) sum(x.^2),[1 2 3])
%  grad =
%      2     4     6
%  err =
%      5.8899e-15    1.178e-14            0
%
%
% Example:
%  At [x,y] = [1,1], compute the numerical gradient
%  of the function sin(x-y) + y*exp(x)
%
%  z = @(xy) sin(diff(xy)) + xy(2)*exp(xy(1))
%
%  [grad,err ] = gradest(z,[1 1])
%  grad =
%       1.7183       3.7183
%  err =
%    7.537e-14   1.1846e-13
%
%
% Example:
%  At the global minimizer (1,1) of the Rosenbrock function,
%  compute the gradient. It should be essentially zero.
%
%  rosen = @(x) (1-x(1)).^2 + 105*(x(2)-x(1).^2).^2;
%  [g,err] = gradest(rosen,[1 1])
%  g =
%    1.0843e-20            0
%  err =
%    1.9075e-18            0
%
%
% See also: derivest, gradient
%
%
% Author: John D'Errico
% e-mail: woodchips@rochester.rr.com
% Release: 1.0
% Release date: 2/9/2007

% total number of derivatives we will need to take
nx = numel(x0);

grad = zeros(1,nx);
err = grad;
finaldelta = grad;
for ind = 1:nx
  [grad(ind),err(ind),finaldelta(ind)] = derivest( ...
    @(xi) fun(swapelement(x0,ind,xi)), ...
    x0(ind),'deriv',1,'vectorized','no', ...
    'methodorder',2);
end

%%
function [der,errest,finaldelta] = derivest(fun,x0,varargin)
% DERIVEST: estimate the n'th derivative of fun at x0, provide an error estimate
% usage: [der,errest] = DERIVEST(fun,x0)  % first derivative
% usage: [der,errest] = DERIVEST(fun,x0,prop1,val1,prop2,val2,...)
%
% Derivest will perform numerical differentiation of an
% analytical function provided in fun. It will not
% differentiate a function provided as data. Use gradient
% for that purpose, or differentiate a spline model.
%
% The methods used by DERIVEST are finite difference
% approximations of various orders, coupled with a generalized
% (multiple term) Romberg extrapolation. This also yields
% the error estimate provided. DERIVEST uses a semi-adaptive
% scheme to provide the best estimate that it can by its
% automatic choice of a differencing interval.
%
% Finally, While I have not written this function for the
% absolute maximum speed, speed was a major consideration
% in the algorithmic design. Maximum accuracy was my main goal.
%
%
% Arguments (input)
%  fun - function to differentiate. May be an inline function,
%        anonymous, or an m-file. fun will be sampled at a set
%        of distinct points for each element of x0. If there are
%        additional parameters to be passed into fun, then use of
%        an anonymous function is recommended.
%
%        fun should be vectorized to allow evaluation at multiple
%        locations at once. This will provide the best possible
%        speed. IF fun is not so vectorized, then you MUST set
%        'vectorized' property to 'no', so that derivest will
%        then call your function sequentially instead.
%
%        Fun is assumed to return a result of the same
%        shape as its input x0.
%
%  x0  - scalar, vector, or array of points at which to
%        differentiate fun.
%
% Additional inputs must be in the form of property/value pairs.
%  Properties are character strings. They may be shortened
%  to the extent that they are unambiguous. Properties are
%  not case sensitive. Valid property names are:
%
%  'DerivativeOrder', 'MethodOrder', 'Style', 'RombergTerms'
%  'FixedStep', 'MaxStep'
%
%  All properties have default values, chosen as intelligently
%  as I could manage. Values that are character strings may
%  also be unambiguously shortened. The legal values for each
%  property are:
%
%  'DerivativeOrder' - specifies the derivative order estimated.
%        Must be a positive integer from the set [1,2,3,4].
%
%        DEFAULT: 1 (first derivative of fun)
%
%  'MethodOrder' - specifies the order of the basic method
%        used for the estimation.
%
%        For 'central' methods, must be a positive integer
%        from the set [2,4].
%
%        For 'forward' or 'backward' difference methods,
%        must be a positive integer from the set [1,2,3,4].
%
%        DEFAULT: 4 (a second order method)
%
%        Note: higher order methods will generally be more
%        accurate, but may also suffere more from numerical
%        problems.
%
%        Note: First order methods would usually not be
%        recommended.
%
%  'Style' - specifies the style of the basic method
%        used for the estimation. 'central', 'forward',
%        or 'backwards' difference methods are used.
%
%        Must be one of 'Central', 'forward', 'backward'.
%
%        DEFAULT: 'Central'
%
%        Note: Central difference methods are usually the
%        most accurate, but sometiems one must not allow
%        evaluation in one direction or the other.
%
%  'RombergTerms' - Allows the user to specify the generalized
%        Romberg extrapolation method used, or turn it off
%        completely.
%
%        Must be a positive integer from the set [0,1,2,3].
%
%        DEFAULT: 2 (Two Romberg terms)
%
%        Note: 0 disables the Romberg step completely.
%
%  'FixedStep' - Allows the specification of a fixed step
%        size, preventing the adaptive logic from working.
%        This will be considerably faster, but not necessarily
%        as accurate as allowing the adaptive logic to run.
%
%        DEFAULT: []
%
%        Note: If specified, 'FixedStep' will define the
%        maximum excursion from x0 that will be used.
%
%  'Vectorized' - Derivest will normally assume that your
%        function can be safely evaluated at multiple locations
%        in a single call. This would minimize the overhead of
%        a loop and additional function call overhead. Some
%        functions are not easily vectorizable, but you may
%        (if your matlab release is new enough) be able to use
%        arrayfun to accomplish the vectorization.
%
%        When all else fails, set the 'vectorized' property
%        to 'no'. This will cause derivest to loop over the
%        successive function calls.
%
%        DEFAULT: 'yes'
%
%
%  'MaxStep' - Specifies the maximum excursion from x0 that
%        will be allowed, as a multiple of x0.
%
%        DEFAULT: 100
%
%  'StepRatio' - Derivest uses a proportionally cascaded
%        series of function evaluations, moving away from your
%        point of evaluation. The StepRatio is the ratio used
%        between sequential steps.
%
%        DEFAULT: 2.0000001
%
%        Note: use of a non-integer stepratio is intentional,
%        to avoid integer multiples of the period of a periodic
%        function under some circumstances.
%
%
% See the document DERIVEST.pdf for more explanation of the
% algorithms behind the parameters of DERIVEST. In most cases,
% I have chosen good values for these parameters, so the user
% should never need to specify anything other than possibly
% the DerivativeOrder. I've also tried to make my code robust
% enough that it will not need much. But complete flexibility
% is in there for your use.
%
%
% Arguments: (output)
%  der - derivative estimate for each element of x0
%        der will have the same shape as x0.
%
%  errest - 95% uncertainty estimate of the derivative, such that
%
%        abs(der(j) - f'(x0(j))) < erest(j)
%
%  finaldelta - The final overall stepsize chosen by DERIVEST
%
%
% Example usage:
%  First derivative of exp(x), at x == 1
%   [d,e]=derivest(@(x) exp(x),1)
%   d =
%       2.71828182845904
%
%   e =
%       1.02015503167879e-14
%
%  True derivative
%   exp(1)
%   ans =
%       2.71828182845905
%
% Example usage:
%  Third derivative of x.^3+x.^4, at x = [0,1]
%   derivest(@(x) x.^3 + x.^4,[0 1],'deriv',3)
%   ans =
%       6       30
%
%  True derivatives: [6,30]
%
%
% See also: gradient
%
%
% Author: John D'Errico
% e-mail: woodchips@rochester.rr.com
% Release: 1.0
% Release date: 12/27/2006

par.DerivativeOrder = 1;
par.MethodOrder = 4;
par.Style = 'central';
par.RombergTerms = 2;
par.FixedStep = [];
par.MaxStep = 0.9;
% setting a default stepratio as a non-integer prevents
% integer multiples of the initial point from being used.
% In turn that avoids some problems for periodic functions.
par.StepRatio = 2.0000001;
par.NominalStep = [];
par.Vectorized = 'yes';

na = length(varargin);
if (rem(na,2)==1)
  error 'Property/value pairs must come as PAIRS of arguments.'
elseif na>0
  par = parse_pv_pairs(par,varargin);
end
par = check_params(par);

% Was fun a string, or an inline/anonymous function?
if (nargin<1)
  help derivest
  return
elseif isempty(fun)
  error 'fun was not supplied.'
elseif ischar(fun)
  % a character function name
  fun = str2func(fun);
end

% no default for x0
if (nargin<2) || isempty(x0)
  error 'x0 was not supplied'
end
par.NominalStep = max(x0,0.02);

% was a single point supplied?
nx0 = size(x0);
n = prod(nx0);

% Set the steps to use.
if isempty(par.FixedStep)
  % Basic sequence of steps, relative to a stepsize of 1.
  delta = par.MaxStep*par.StepRatio .^(0:-1:-25)';
  ndel = length(delta);
else
  % Fixed, user supplied absolute sequence of steps.
  ndel = 3 + ceil(par.DerivativeOrder/2) + ...
     par.MethodOrder + par.RombergTerms;
  if par.Style(1) == 'c'
    ndel = ndel - 2;
  end
  delta = par.FixedStep*par.StepRatio .^(-(0:(ndel-1)))';
end

% generate finite differencing rule in advance.
% The rule is for a nominal unit step size, and will
% be scaled later to reflect the local step size.
fdarule = 1;
switch par.Style
  case 'central'
    % for central rules, we will reduce the load by an
    % even or odd transformation as appropriate.
    if par.MethodOrder==2
      switch par.DerivativeOrder
        case 1
          % the odd transformation did all the work
          fdarule = 1;
        case 2
          % the even transformation did all the work
          fdarule = 2;
        case 3
          % the odd transformation did most of the work, but
          % we need to kill off the linear term
          fdarule = [0 1]/fdamat(par.StepRatio,1,2);
        case 4
          % the even transformation did most of the work, but
          % we need to kill off the quadratic term
          fdarule = [0 1]/fdamat(par.StepRatio,2,2);
      end
    else
      % a 4th order method. We've already ruled out the 1st
      % order methods since these are central rules.
      switch par.DerivativeOrder
        case 1
          % the odd transformation did most of the work, but
          % we need to kill off the cubic term
          fdarule = [1 0]/fdamat(par.StepRatio,1,2);
        case 2
          % the even transformation did most of the work, but
          % we need to kill off the quartic term
          fdarule = [1 0]/fdamat(par.StepRatio,2,2);
        case 3
          % the odd transformation did much of the work, but
          % we need to kill off the linear & quintic terms
          fdarule = [0 1 0]/fdamat(par.StepRatio,1,3);
        case 4
          % the even transformation did much of the work, but
          % we need to kill off the quadratic and 6th order terms
          fdarule = [0 1 0]/fdamat(par.StepRatio,2,3);
      end
    end
  case {'forward' 'backward'}
    % These two cases are identical, except at the very end,
    % where a sign will be introduced.

    % No odd/even trans, but we already dropped
    % off the constant term
    if par.MethodOrder==1
      if par.DerivativeOrder==1
        % an easy one
        fdarule = 1;
      else
        % 2:4
        v = zeros(1,par.DerivativeOrder);
        v(par.DerivativeOrder) = 1;
        fdarule = v/fdamat(par.StepRatio,0,par.DerivativeOrder);
      end
    else
      % par.MethodOrder methods drop off the lower order terms,
      % plus terms directly above DerivativeOrder
      v = zeros(1,par.DerivativeOrder + par.MethodOrder - 1);
      v(par.DerivativeOrder) = 1;
      fdarule = v/fdamat(par.StepRatio,0,par.DerivativeOrder+par.MethodOrder-1);
    end
    
    % correct sign for the 'backward' rule
    if par.Style(1) == 'b'
      fdarule = -fdarule;
    end
    
end % switch on par.style (generating fdarule)
nfda = length(fdarule);

% will we need fun(x0)?
if (rem(par.DerivativeOrder,2) == 0) || ~strncmpi(par.Style,'central',7)
  if strcmpi(par.Vectorized,'yes')
    f_x0 = fun(x0);
  else
    % not vectorized, so loop
    f_x0 = zeros(size(x0));
    for j = 1:numel(x0)
      f_x0(j) = fun(x0(j));
    end
  end
else
  f_x0 = [];
end

% Loop over the elements of x0, reducing it to
% a scalar problem. Sorry, vectorization is not
% complete here, but this IS only a single loop.
der = zeros(nx0);
errest = der;
finaldelta = der;
for i = 1:n
  x0i = x0(i);
  h = par.NominalStep(i);

  % a central, forward or backwards differencing rule?
  % f_del is the set of all the function evaluations we
  % will generate. For a central rule, it will have the
  % even or odd transformation built in.
  if par.Style(1) == 'c'
    % A central rule, so we will need to evaluate
    % symmetrically around x0i.
    if strcmpi(par.Vectorized,'yes')
      f_plusdel = fun(x0i+h*delta);
      f_minusdel = fun(x0i-h*delta);
    else
      % not vectorized, so loop
      f_minusdel = zeros(size(delta));
      f_plusdel = zeros(size(delta));
      for j = 1:numel(delta)
        f_plusdel(j) = fun(x0i+h*delta(j));
        f_minusdel(j) = fun(x0i-h*delta(j));
      end
    end
    
    if ismember(par.DerivativeOrder,[1 3])
      % odd transformation
      f_del = (f_plusdel - f_minusdel)/2;
    else
      f_del = (f_plusdel + f_minusdel)/2 - f_x0(i);
    end
  elseif par.Style(1) == 'f'
    % forward rule
    % drop off the constant only
    if strcmpi(par.Vectorized,'yes')
      f_del = fun(x0i+h*delta) - f_x0(i);
    else
      % not vectorized, so loop
      f_del = zeros(size(delta));
      for j = 1:numel(delta)
        f_del(j) = fun(x0i+h*delta(j)) - f_x0(i);
      end
    end
  else
    % backward rule
    % drop off the constant only
    if strcmpi(par.Vectorized,'yes')
      f_del = fun(x0i-h*delta) - f_x0(i);
    else
      % not vectorized, so loop
      f_del = zeros(size(delta));
      for j = 1:numel(delta)
        f_del(j) = fun(x0i-h*delta(j)) - f_x0(i);
      end
    end
  end
  
  % check the size of f_del to ensure it was properly vectorized.
  f_del = f_del(:);
  if length(f_del)~=ndel
    error 'fun did not return the correct size result (fun must be vectorized)'
  end

  % Apply the finite difference rule at each delta, scaling
  % as appropriate for delta and the requested DerivativeOrder.
  % First, decide how many of these estimates we will end up with.
  ne = ndel + 1 - nfda - par.RombergTerms;

  % Form the initial derivative estimates from the chosen
  % finite difference method.
  der_init = vec2mat(f_del,ne,nfda)*fdarule.';

  % scale to reflect the local delta
  der_init = der_init(:)./(h*delta(1:ne)).^par.DerivativeOrder;
  
  % Each approximation that results is an approximation
  % of order par.DerivativeOrder to the desired derivative.
  % Additional (higher order, even or odd) terms in the
  % Taylor series also remain. Use a generalized (multi-term)
  % Romberg extrapolation to improve these estimates.
  switch par.Style
    case 'central'
      rombexpon = 2*(1:par.RombergTerms) + par.MethodOrder - 2;
    otherwise
      rombexpon = (1:par.RombergTerms) + par.MethodOrder - 1;
  end
  [der_romb,errors] = rombextrap(par.StepRatio,der_init,rombexpon);
  
  % Choose which result to return
  
  % first, trim off the 
  if isempty(par.FixedStep)
    % trim off the estimates at each end of the scale
    nest = length(der_romb);
    switch par.DerivativeOrder
      case {1 2}
        trim = [1 2 nest-1 nest];
      case 3
        trim = [1:4 nest+(-3:0)];
      case 4
        trim = [1:6 nest+(-5:0)];
    end
    
    [der_romb,tags] = sort(der_romb);
    
    der_romb(trim) = [];
    tags(trim) = [];
    errors = errors(tags);
    trimdelta = delta(tags);
    
    [errest(i),ind] = min(errors);
    
    finaldelta(i) = h*trimdelta(ind);
    der(i) = der_romb(ind);
  else
    [errest(i),ind] = min(errors);
    finaldelta(i) = h*delta(ind);
    der(i) = der_romb(ind);
  end
end

%%
% ============================================
% Subfunction - romberg extrapolation
% ============================================
function [der_romb,errest] = rombextrap(StepRatio,der_init,rombexpon)
% do romberg extrapolation for each estimate
%
%  StepRatio - Ratio decrease in step
%  der_init - initial derivative estimates
%  rombexpon - higher order terms to cancel using the romberg step
%
%  der_romb - derivative estimates returned
%  errest - error estimates
%  amp - noise amplification factor due to the romberg step

srinv = 1/StepRatio;

% do nothing if no romberg terms
nexpon = length(rombexpon);
rmat = ones(nexpon+2,nexpon+1);
switch nexpon
  case 0
    % rmat is simple: ones(2,1)
  case 1
    % only one romberg term
    rmat(2,2) = srinv^rombexpon;
    rmat(3,2) = srinv^(2*rombexpon);
  case 2
    % two romberg terms
    rmat(2,2:3) = srinv.^rombexpon;
    rmat(3,2:3) = srinv.^(2*rombexpon);
    rmat(4,2:3) = srinv.^(3*rombexpon);
  case 3
    % three romberg terms
    rmat(2,2:4) = srinv.^rombexpon;
    rmat(3,2:4) = srinv.^(2*rombexpon);
    rmat(4,2:4) = srinv.^(3*rombexpon);
    rmat(5,2:4) = srinv.^(4*rombexpon);
end

% qr factorization used for the extrapolation as well
% as the uncertainty estimates
[qromb,rromb] = qr(rmat,0);

% the noise amplification is further amplified by the Romberg step.
% amp = cond(rromb);

% this does the extrapolation to a zero step size.
ne = length(der_init);
rhs = vec2mat(der_init,nexpon+2,max(1,ne - (nexpon+2)));
rombcoefs = rromb\(qromb.'*rhs); 
der_romb = rombcoefs(1,:).';

% uncertainty estimate of derivative prediction
s = sqrt(sum((rhs - rmat*rombcoefs).^2,1));
rinv = rromb\eye(nexpon+1);
cov1 = sum(rinv.^2,2); % 1 spare dof
errest = s.'*12.7062047361747*sqrt(cov1(1));


%%
% ============================================
% Subfunction - check_params
% ============================================
function par = check_params(par)
% check the parameters for acceptability
%
% Defaults
% par.DerivativeOrder = 1;
% par.MethodOrder = 2;
% par.Style = 'central';
% par.RombergTerms = 2;
% par.FixedStep = [];

% DerivativeOrder == 1 by default
if isempty(par.DerivativeOrder)
  par.DerivativeOrder = 1;
else
  if (length(par.DerivativeOrder)>1) || ~ismember(par.DerivativeOrder,1:4)
    error 'DerivativeOrder must be scalar, one of [1 2 3 4].'
  end
end

% MethodOrder == 2 by default
if isempty(par.MethodOrder)
  par.MethodOrder = 2;
else
  if (length(par.MethodOrder)>1) || ~ismember(par.MethodOrder,[1 2 3 4])
    error 'MethodOrder must be scalar, one of [1 2 3 4].'
  elseif ismember(par.MethodOrder,[1 3]) && (par.Style(1)=='c')
    error 'MethodOrder==1 or 3 is not possible with central difference methods'
  end
end

% style is char
valid = {'central', 'forward', 'backward'};
if isempty(par.Style)
  par.Style = 'central';
elseif ~ischar(par.Style)
  error 'Invalid Style: Must be character'
end
ind = find(strncmpi(par.Style,valid,length(par.Style)));
if (length(ind)==1)
  par.Style = valid{ind};
else
  error(['Invalid Style: ',par.Style])
end

% vectorized is char
valid = {'yes', 'no'};
if isempty(par.Vectorized)
  par.Vectorized = 'yes';
elseif ~ischar(par.Vectorized)
  error 'Invalid Vectorized: Must be character'
end
ind = find(strncmpi(par.Vectorized,valid,length(par.Vectorized)));
if (length(ind)==1)
  par.Vectorized = valid{ind};
else
  error(['Invalid Vectorized: ',par.Vectorized])
end

% RombergTerms == 2 by default
if isempty(par.RombergTerms)
  par.RombergTerms = 2;
else
  if (length(par.RombergTerms)>1) || ~ismember(par.RombergTerms,0:3)
    error 'RombergTerms must be scalar, one of [0 1 2 3].'
  end
end

% FixedStep == [] by default
if (length(par.FixedStep)>1) || (~isempty(par.FixedStep) && (par.FixedStep<=0))
  error 'FixedStep must be empty or a scalar, >0.'
end

% MaxStep == 10 by default
if isempty(par.MaxStep)
  par.MaxStep = 10;
elseif (length(par.MaxStep)>1) || (par.MaxStep<=0)
  error 'MaxStep must be empty or a scalar, >0.'
end


%%
% ============================================
% Subfunction - parse_pv_pairs
% ============================================
function params=parse_pv_pairs(params,pv_pairs)
% parse_pv_pairs: parses sets of property value pairs, allows defaults
% usage: params=parse_pv_pairs(default_params,pv_pairs)
%
% arguments: (input)
%  default_params - structure, with one field for every potential
%             property/value pair. Each field will contain the default
%             value for that property. If no default is supplied for a
%             given property, then that field must be empty.
%
%  pv_array - cell array of property/value pairs.
%             Case is ignored when comparing properties to the list
%             of field names. Also, any unambiguous shortening of a
%             field/property name is allowed.
%
% arguments: (output)
%  params   - parameter struct that reflects any updated property/value
%             pairs in the pv_array.
%
% Example usage:
% First, set default values for the parameters. Assume we
% have four parameters that we wish to use optionally in
% the function examplefun.
%
%  - 'viscosity', which will have a default value of 1
%  - 'volume', which will default to 1
%  - 'pie' - which will have default value 3.141592653589793
%  - 'description' - a text field, left empty by default
%
% The first argument to examplefun is one which will always be
% supplied.
%
%   function examplefun(dummyarg1,varargin)
%   params.Viscosity = 1;
%   params.Volume = 1;
%   params.Pie = 3.141592653589793
%
%   params.Description = '';
%   params=parse_pv_pairs(params,varargin);
%   params
%
% Use examplefun, overriding the defaults for 'pie', 'viscosity'
% and 'description'. The 'volume' parameter is left at its default.
%
%   examplefun(rand(10),'vis',10,'pie',3,'Description','Hello world')
%
% params = 
%     Viscosity: 10
%        Volume: 1
%           Pie: 3
%   Description: 'Hello world'
%
% Note that capitalization was ignored, and the property 'viscosity'
% was truncated as supplied. Also note that the order the pairs were
% supplied was arbitrary.

npv = length(pv_pairs);
n = npv/2;

if n~=floor(n)
  error 'Property/value pairs must come in PAIRS.'
end
if n<=0
  % just return the defaults
  return
end

if ~isstruct(params)
  error 'No structure for defaults was supplied'
end

% there was at least one pv pair. process any supplied
propnames = fieldnames(params);
lpropnames = lower(propnames);
for i=1:n
  p_i = lower(pv_pairs{2*i-1});
  v_i = pv_pairs{2*i};
  
  ind = find(strcmp(p_i,lpropnames));
  if isempty(ind)
    ind = find(strncmp(p_i,lpropnames,length(p_i)));
    if isempty(ind)
      error(['No matching property found for: ',pv_pairs{2*i-1}])
    elseif length(ind)>1
      error(['Ambiguous property name: ',pv_pairs{2*i-1}])
    end
  end
  p_i = propnames{ind};
  
  % override the corresponding default in params
  params = setfield(params,p_i,v_i); %#ok  
end

%% 
% ============================================
% Subfunction - vec2mat
% ============================================
function mat = vec2mat(vec,n,m)
% forms the matrix M, such that M(i,j) = vec(i+j-1)
[i,j] = ndgrid(1:n,0:m-1);
ind = i+j;
mat = vec(ind);
if n==1
  mat = mat.';
end


%%
% ============================================
% Subfunction - fdamat
% ============================================
function mat = fdamat(sr,parity,nterms)
% Compute matrix for fda derivation.
% parity can be
%   0 (one sided, all terms included but zeroth order)
%   1 (only odd terms included)
%   2 (only even terms included)
% nterms - number of terms

% sr is the ratio between successive steps
srinv = 1./sr;

switch parity
  case 0
    % single sided rule
    [i,j] = ndgrid(1:nterms);
    c = 1./factorial(1:nterms);
    mat = c(j).*srinv.^((i-1).*j);
  case 1
    % odd order derivative
    [i,j] = ndgrid(1:nterms);
    c = 1./factorial(1:2:(2*nterms));
    mat = c(j).*srinv.^((i-1).*(2*j-1));
  case 2
    % even order derivative
    [i,j] = ndgrid(1:nterms);
    c = 1./factorial(2:2:(2*nterms));
    mat = c(j).*srinv.^((i-1).*(2*j));
end



%%
% =======================================
%      Sub-function
% =======================================
function vec = swapelement(vec,ind,val)
% swaps val as element ind, into the vector vec
vec(ind) = val;


%%
% =======================================
%      Sub-function
% =======================================
function vec = swap2(vec,ind1,val1,ind2,val2)
% swaps val as element ind, into the vector vec
vec(ind1) = val1;
vec(ind2) = val2;


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    a = str2double(get(handles.editFilter2After,'String'));
    b = str2double(get(handles.editFilter2Before,'String'));
    
    if (b >= 2050) 

        set(handles.editFilter2Before,'String',a);
        set(handles.editFilter2After,'String',1950);
        handles.Before = a;
        handles.After = 1950;
    end 
    
    if (a <= 1950) 
        
        set(handles.editFilter2Before,'String',2050);
        set(handles.editFilter2After,'String',b);
        handles.Before = 2050;
        handles.After = b;
        
    end     
    
    guidata(hObject, handles);
    
    if get(handles.radiobuttonFilter2DiedBetween,'Value') == 1
        MakeScatterPlot(hObject,handles);
    end


% --- Executes on button press in checkboxNewIDL.
function checkboxNewIDL_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxNewIDL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxNewIDL

handles.newIDL = get(hObject,'Value');
guidata(hObject, handles);

% --- Executes on button press in checkboxFilterTXT.
function checkboxFilterTXT_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxFilterTXT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxFilterTXT
