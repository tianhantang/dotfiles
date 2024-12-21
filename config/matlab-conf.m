% @file: matlab-conf.m
%{
	@brief: User Startup Preference of MATLAB

	@date:
	- created on 2019-11-01
	- updated on 2023-07-17
	
	@note:
	- normal folder is used for 3rd party toolbox instead of using "+package";
	- the main problem of using "package" in MATLAB is that functions DO NOT KNOWN EACH OTHER in the package*, that is, funcA and funcB also must refer to each other by `mypack.funcA` and `mypack.funcB`. this would add a layer of overhead when adopting 3rd party toolbox that is NOT designed like so.
	- see MATLAB help doc on "Packages Create Namespaces" for more details.
%}

% setup workspace.
% ---------------------
BOX_NAME = char(java.net.InetAddress.getLocalHost.getHostName);
HOME_DIR = char(java.lang.System.getProperty('user.home'));

if startsWith(BOX_NAME, 'PD-Panda', 'IgnoreCase', true)
	wksp = fullfile(HOME_DIR, 'Workspace3');
	toolpath = wksp; % local tool-chain
elseif startsWith(BOX_NAME, 'Lily-Titan', 'IgnoreCase', true)
	wksp = fullfile(HOME_DIR, 'Workspace4');
	toolpath = wksp; % local tool-chain
end

% load external packages.
% ---------------------
if isfolder(toolpath)
	cellfun( ...
		@(TOOLNAME) addpath(fullfile(toolpath, 'git-repo', TOOLNAME)), ...
		{
			'tangt-MATLAB-utility' ...
		}, ...
		'un', 0 ...
	);
else
	disp('CAUTION: the custom toolchain is NOT available!');
end

cd(wksp);

% clean-up those setup variables.
% ---------------------
clearvars;
