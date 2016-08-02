;; RETURN(length: sp[-1], offset: sp[-2])
(func $RETURN
  (param $sp i32)
  ;;(param $memstart i32)
  (local $memstart i32)
  (local $offset i32)
  (local $length i32)
  (local $offset0 i64)
  (local $offset1 i64)
  (local $offset2 i64)
  (local $offset3 i64)
  (local $length0 i64)
  (local $length1 i64)
  (local $length2 i64)
  (local $length3 i64)
  (result i32)

  ;; Hardcode memory start at 32k: https://github.com/ewasm/evm2wasm/issues/16
  (set_local $memstart (i32.const 32768))

  ;; load args from the stack
  (set_local $offset0 (i64.load (get_local $sp)))
  (set_local $offset1 (i64.load (i32.sub (get_local $sp) (i32.const 8))))
  (set_local $offset2 (i64.load (i32.sub (get_local $sp) (i32.const 16))))
  (set_local $offset3 (i64.load (i32.sub (get_local $sp) (i32.const 24))))

  (set_local $length0 (i64.load (i32.sub (get_local $sp) (i32.const 32))))
  (set_local $length1 (i64.load (i32.sub (get_local $sp) (i32.const 40))))
  (set_local $length2 (i64.load (i32.sub (get_local $sp) (i32.const 48))))
  (set_local $length3 (i64.load (i32.sub (get_local $sp) (i32.const 56))))

  ;; FIXME: how to deal with overflow?
  (set_local $offset (i32.wrap/i64 (get_local $offset3)))
  (set_local $length (i32.wrap/i64 (get_local $length3)))

  (call_import $return (i32.add (get_local $offset) (get_local $memstart)) (get_local $length))

  (set_local $sp (i32.sub (get_local $sp) (i32.const 64)))
  (return (get_local $sp))
)
