#! /usr/bin/env python
# Generic RE challenge solver

import sys
import argparse

import angr
import claripy


def clean(angr_answer):
  """ angr deals in byte strings, which are not always null-terminated, so
clean things up a bit. """
  # angr can return non-ascii characters into stdout; we don't want to decode
  # these, since we're assuming flags are ascii printable.
  return angr_answer.decode("utf-8", errors="ignore")

def main():
  parser = argparse.ArgumentParser(
    description="Solve the given CTF binary; find the flag!"
  )

  parser.add_argument(
    "binary",
    help="file path to the binary containing CTF flag"
  )

  parser.add_argument(
    "--target-input",
    required=False,
    help="Specify a target input string to aim for"
  )

  parser.add_argument(
    "--target-output",
    required=False,
    help="Specify a target output string to aim for"
  )

  parser.add_argument(
    "--avoid-input",
    required=False,
    help="Specify an input string to avoid reaching"
  )

  parser.add_argument(
    "--avoid-output",
    required=False,
    help="Specify an output string to avoid reaching"
  )

  parser.add_argument(
    "--max-input-length",
    required=False,
    default=80,
    help="Indicate the expected maximum input string length, in bytes"
  )

  # Parse arguments
  args = parser.parse_args()

  # Create angr project with symbolic input argument
  # NOTE: for some reason this also applies the sym arg to stdin?
  exe = angr.Project(args.binary)
  sym_arg = claripy.BVS('input', 8 * int(args.max_input_length))
  argv = [exe.filename, sym_arg]

  # Initialize the start state with our symbolic arg:
  state = exe.factory.entry_state(args = argv)
  state.options.add("ZERO_FILL_UNCONSTRAINED_MEMORY")
  state.options.add("ZERO_FILL_UNCONSTRAINED_REGISTERS")
  sm = exe.factory.simulation_manager(state)

  # Search predicates
  find_func = None
  avoid_func = None

  if args.target_input:
    print(f"Searching for branches with input: {args.target_input}")
    find_func = lambda state: \
      args.target_input.encode('utf-8') in state.posix.dumps(0)
  elif args.target_output:
    print(f"Searching for branches with output: {args.target_output}")
    find_func = lambda state: \
      args.target_output.encode('utf-8') in state.posix.dumps(1)
  elif args.avoid_input:
    print(f"Searching for branches without input: {args.avoid_input}")
    avoid_func = lambda state: \
      args.avoid_input.encode('utf-8') in state.posix.dumps(0)
  elif args.avoid_output:
    print(f"Searching for branches without output: {args.avoid_output}")
    avoid_func = lambda state: \
      args.avoid_output.encode('utf-8') in state.posix.dumps(1)
  else:
    # No strings to search for, just dump I/O on first branch and exit
    sm.run(until=lambda sm_: len(sm_.active) > 1)

    print(f"Found {len(sm.active)} branches")
    for i, branch in enumerate(sm.active, start=1):
      print(f"Branch {i}:")
      print(f"Branch input: {branch.posix.dumps(0)}")
      print(f"Branch output: {branch.posix.dumps(1)}")
    exit()

  # Apply predicates to the simulator
  sm.explore(
    find = find_func,
    avoid = avoid_func
  )

  if sm.found:
    # We've found at least one candidate branch
    for i, result in enumerate(sm.found, start=1):
      print(f"Branch {i}")
      print(f"stdin:\n{str(clean(result.posix.dumps(0)))}")
      print(f"stdout:\n{str(clean(result.posix.dumps(1)))}")
      print(f"stderr:\n{str(clean(result.posix.dumps(2)))}")
  else:
    print("No candidates found.\n")    


if __name__ == "__main__":
  main()