@events.on_chdir
def _zoxide_hook(olddir, newdir, **kw):
    zoxide add > /dev/null

def _z_cd(arg):
    s = ![cd @(arg)] 
    if not s:
        return s.rtn

    if "_ZO_ECHO" in ${...}:
        echo $PWD

def _z(args):
    if len(args) == 0:
        _z_cd("~")
    elif len(args) == 1 and args[0] == "-":
        if "OLDPWD" in ${...}:
            _z_cd($OLDPWD)
        else:
            print('zoxide: $OLDPWD is not set')
            return 1
    else:
        query_result = $(zoxide query @(" ".join(args)) err>out).strip()
        if pf"{query_result}".is_dir():
            _z_cd(query_result)
        elif len(query_result) > 0:
            echo @(query_result)


aliases['z'] = _z

aliases['zi'] = 'z -i'
aliases['za'] = 'zoxide add'
aliases['zq'] = 'zoxide query'
aliases['zr'] = 'zoxide remove'
