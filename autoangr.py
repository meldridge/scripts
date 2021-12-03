import angr, claripy
import logging, sys, time, argparse

parser = argparse.ArgumentParser()
parser.add_argument('-i', type=str, help='input file', required=True)
parser.add_argument('-f', type=str, help='address to find')
parser.add_argument('-s', type=str, help='string to find (in output)')
parser.add_argument('-a', type=str, help='address to avoid')
parser.add_argument('-l', type=int, help='length of stdin (if known)')
parser.add_argument('-c', type=int, help='length of cmdline arg (if known)')
parser.add_argument('-args', type=list, help='additional command line args required')
args = parser.parse_args()

if(args.f is None and args.s is None):
    # lets not worry if both are entered for now, we'll work with the address
    print("Error: address or string to find is required")
    exit()

logging.basicConfig(level=logging.DEBUG)
proj = angr.Project(args.i)

argv = [args.i]
if args.args:
    for a in args.args:
        argv.append(a)

if args.l:
    flag_chars = [claripy.BVS('flag_%d' % i, 8) for i in range(args.l)]
    #this assumes we end with a newline
    flag = claripy.Concat(*flag_chars + [claripy.BVV(b'\n')])
    #we'll eventually need to give default argv[1] (args=['./binary'])
    init_state = proj.factory.entry_state(args=argv, stdin=flag)
    for k in flag_chars:
        # constrain to printable chars
        init_state.solver.add(k>=32)
        init_state.solver.add(k<=0x7f)
elif args.c:
    flag_chars = [claripy.BVS('flag_%d' % i, 8) for i in range(args.c)]
    flag = claripy.Concat(*flag_chars)
    init_state = proj.factory.entry_state(args=[args.i, flag])
    for k in flag_chars:
        # constrain to printable chars
        init_state.solver.add(k>=32)
        init_state.solver.add(k<=0x7f)
else:
    init_state = proj.factory.entry_state(args=argv)
sim = proj.factory.simgr(init_state)
if args.f and args.a:
    sim.explore(find=int(args.f, 16), avoid=int(args.a, 16))
elif args.f:
    sim.explore(find=int(args.f, 16))
elif args.s and args.a:
    sim.explore(find=lambda s: bytes(args.s,'utf-8') in s.posix.dumps(1), avoid=int(args.a, 16))
elif args.s:
    sim.explore(find=lambda s: bytes(args.s,'utf-8') in s.posix.dumps(1))
if sim.found:
    logging.info("Found it!")
    if args.c:
        print(sim.found[0].solver.eval(flag, cast_to=bytes))
    else:
        print(sim.found[0].posix.dumps(sys.stdin.fileno()))
else:
    raise Exception("No dice")

sim.found[0].solver.eval(flag, cast_to=bytes)
