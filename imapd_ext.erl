%%%----------------------------------------------------------------------
%%% File        : imapd_ext
%%% Author      : Stuart Jackson <sjackson@simpleenigma.com> [http://www.simpleenigma.com]
%%% Purpose     : IMAP server extention processing
%%% Created     : 2007-10-27
%%% Initial Rel : 0.0.6
%%% Updated     : 2007-10-27
%%%----------------------------------------------------------------------
-module(imapd_ext).
-author('sjackson@simpleenigma.com').
-include("imap.hrl").

-export([list/0,list/1,verify/2,check/1]).
-export([capability/0]).


% Check and verify extentions and return capability string
capability() ->
	Cap = lists:foldl(fun({_M,Ext},Acc) -> [32,http_util:to_upper(atom_to_list(Ext))|Acc] 
		end,[32,"IMAP4rev1"],list()),
	string:strip(lists:flatten(lists:reverse(Cap))).


check(Key) ->
	case lists:keysearch(Key,2,list()) of
		{value,{Module,Function}} -> {ok,Module,Function};
		_ -> {error,extention_not_found}
	end.


% get potential extentions from config file and verify before returning list
list() -> list(erlmail_conf:lookup(server_imap_extentions)).
list(String) -> 
	Tokens = string:tokens(String,[32]),
	Ext = lists:map(fun(Ext) -> 
		case string:tokens(Ext,[58]) of
			[M,F] -> {list_to_atom(M),list_to_atom(F)};
			[F] -> {imapd_ext,list_to_atom(F)}
		end
		end,Tokens),
	lists:foldl(fun({Module,Function},Acc) ->
		case verify(Module,Function) of
			ok -> [{Module,Function}|Acc];
			_ -> Acc
		end
		end,[],Ext).
	


%% Verify that Module:Function/2 exists
verify(Module,Function) ->
	case code:get_object_code(Module) of
		{Module,_Obj,BeamPath} ->
			case beam_lib:chunks(BeamPath,[exports]) of
				{ok,{_Mod,[{exports,Exports}]}} ->
					case lists:member({Function,2},Exports) of
						true -> ok;
						false -> {error,function_not_found}
					end;
				{error,_BeamLib,Reason} -> {error,Reason}
			end;
		error -> {error,module_not_loaded}
	end.