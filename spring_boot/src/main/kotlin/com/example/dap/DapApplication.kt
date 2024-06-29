package com.example.dap

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class DapApplication

fun main(args: Array<String>) {
	runApplication<DapApplication>(*args)
}
