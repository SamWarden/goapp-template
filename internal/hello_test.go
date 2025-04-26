package hello_test

import (
	"bytes"
	"gotemplate/internal"
	"io"
	"os"
	"testing"
)

func TestPrintHelloWorld(t *testing.T) {
	originalStdout := os.Stdout

	r, w, _ := os.Pipe()
	os.Stdout = w

	hello.PrintHelloWorld()

	w.Close()
	var buf bytes.Buffer
	io.Copy(&buf, r)

	os.Stdout = originalStdout

	got := buf.String()
	want := "Hello World!\n"

	if got != want {
		t.Errorf("expected %q, got %q", want, got)
	}
}
