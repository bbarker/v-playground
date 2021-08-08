import os

fn main() {

/*
x := Alphabet(Abc{'test'}) // sum type

// match must be exhausive
match x {
    Abc {
      // x is automatically casted to Abc and can be used here
      println(x)
    }
    /* Xyz {
      // x is automatically casted to Xyz and can be used here
      println(x)
    } */
  }
*/


  /* // This doesn't compile, which is good
  unit := if true {println('foo')} else {println('bar')}
  println(unit)
  */


  /*
  numbers := map{
    'one': Point{1, 1}
    'two': Point{2, 2}
  }
  println(numbers['bad_key'])
  */

  // TODO: investigate custom HOFs
/*   nums := [1, 2, 3, 4, 5, 6]
  evens := nums.filter(it % 2 == 0)
  println(evens) */

}

struct Abc {
	val string
}

struct Xyz {
	foo string
}

type Alphabet = Abc | Xyz

struct Point {
	x int
	y int
}

/*
fn fmap(value int, op fn (int) int) int {
	return op(value)
}
*/

fn get_input() string {
  return os.input('Enter a string')
}


/*
struct Foo {
    a int
  mut:
    b int
}

fn foo(fval Foo) int {
  fval.b = 3 // Can't write here
  return fval.b
}
*/

/* *** *** *** *** *** *** *** ***  Type Classes *** *** *** *** *** ***  */

/*
interface Gettable<T> {
  get() T
}
*/

/*
interface GettableTwo {
  T any
  A any
  get fn (A) T
}
*/

struct Gettable<A, T> {
  pub:
    get fn (A) T
}


struct WithGettable<A, T> {
  Gettable<A, T>
  // Put some extra stuff
}

struct Animal<T> {
  metadata T
}


/*
fn extract([]Gettable<T> xs) []T {
  return xs.map(it.get())
}
*/



fn extract<A, T>(xs []A, Get WithGettable<A, T>) []T {
  return xs.map(Get.get(it))
}


// jorkermc/div72: I guess you can make a poor man's generics with returning voidptr in the interface and casting in your function.

struct DB<T> {
  db int
}

struct Repo<T> {
    db DB
}

struct User {
	id   int
	name string
}

struct Post {
	id   int
	user_id int
	title string
	body string
}

fn new_repo<T>(db DB<T>) Repo<T> {
    return Repo<T>{db: db}
}

// This is a generic function. V will generate it for every type it's used with.
fn (r Repo<T>) find_by_id(id int) ?T {
    table_name := T.name // in this example getting the name of the type gives us the table name
    return r.db.query_one<T>('select * from $table_name where id = ?', id)
}

fn repo_examples() {
/*   db := new_db()
  users_repo := new_repo<User>(db) // returns Repo<User>
  posts_repo := new_repo<Post>(db) // returns Repo<Post>
  user := users_repo.find_by_id(1)? // find_by_id<User>
  post := posts_repo.find_by_id(1)? // find_by_id<Post> */
}