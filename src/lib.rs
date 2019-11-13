extern crate libc;

use libc::{ c_int, c_void, c_char, uintptr_t, c_ulong };
use std::ffi::{ CString, CStr };
use std::slice;
use types::Boolean;

type VALUE = c_ulong;
type ID = uintptr_t;
#[allow(non_camel_case_types)]
type void = c_void;
#[allow(non_camel_case_types)]
type c_func = *const void;

mod types;

extern "C" {
  static rb_cSymbol: VALUE;

  fn rb_define_method(klass: VALUE, name: *const c_char, func: c_func, argc: c_int);

  fn rb_id2name(id: ID) -> *const c_char;

  fn rb_sym2id(id: VALUE) -> ID;
}

extern fn rb_sym_start_with(argc: c_int, argv: *const VALUE, rb_self: VALUE) -> VALUE {
  // if no arguments return false
  if argc == 0 { return Boolean::False as VALUE };

  // parse variable arguments into vec.
  let argv = unsafe { slice::from_raw_parts(argv, argc as usize).to_vec() };

  // transform Symbol into String
  let receiver_ptr: *const c_char = unsafe { rb_id2name(rb_sym2id(rb_self)) };
  let receiver_str: String = unsafe { CStr::from_ptr(receiver_ptr).to_string_lossy().into_owned() };

  for arg in argv {
    let sym_ptr: *const c_char = unsafe { rb_id2name(rb_sym2id(arg)) };
    let string: String = unsafe { CStr::from_ptr(sym_ptr).to_string_lossy().into_owned() };

    if receiver_str.starts_with(&string) { return Boolean::True as VALUE }
  };
  Boolean::False as VALUE
}

extern fn rb_sym_end_with(argc: c_int, argv: *const VALUE, rb_self: VALUE) -> VALUE {
  // if no arguments return false
  if argc == 0 { return Boolean::False as VALUE };

  // parse variable arguments into vec.
  let argv = unsafe { slice::from_raw_parts(argv, argc as usize).to_vec() };

  // transform Symbol into String
  let receiver_ptr: *const c_char = unsafe { rb_id2name(rb_sym2id(rb_self)) };
  let receiver_str: String = unsafe { CStr::from_ptr(receiver_ptr).to_string_lossy().into_owned() };

  for arg in argv {
    let sym_ptr: *const c_char = unsafe { rb_id2name(rb_sym2id(arg)) };
    let string: String = unsafe { CStr::from_ptr(sym_ptr).to_string_lossy().into_owned() };

    if receiver_str.ends_with(&string) { return Boolean::True as VALUE }
  };
  Boolean::False as VALUE
}

#[allow(non_snake_case)]
#[no_mangle]
pub extern "C" fn Init_rusty_symbol() {
  let sym_start_with = CString::new("start_with?").unwrap();
  let sym_end_with   = CString::new("end_with?").unwrap();

  unsafe {
    rb_define_method(rb_cSymbol, sym_start_with.as_ptr(), rb_sym_start_with as c_func, -1);
    rb_define_method(rb_cSymbol, sym_end_with.as_ptr(), rb_sym_end_with as c_func, -1);
  }
}
