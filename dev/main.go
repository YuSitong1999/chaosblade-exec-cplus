package main

import (
	"context"
	"fmt"
	"github.com/chaosblade-io/chaosblade-spec-go/channel"
)

func main() {
	//name := "shell_response_delay_attach_parent"
	name := "main"
	pids, err := channel.NewLocalChannel().GetPidsByProcessName(name, context.Background())
	if err != nil {
		panic(err)
	}
	fmt.Printf("%#v\n", pids)
}
