// time_pipe.c : Gets run time using pipes
// Created By: Yuval Noiman and two partners

#include <stdio.h>
#include <string.h>
#include <unistd.h> 
#include <sys/wait.h>
#include <sys/time.h>
#include <stdlib.h>

int myShell(int argc, char *argv[])
{
  pid_t pid;
  
  //sets command for execvp
  char *args[] ={NULL,NULL,NULL,NULL,NULL};
  args[0] = argv[1];
  args[1] = argv[2];
  args[2] = argv[3];
  args[3] = argv[4];
  args[4] = argv[5];
  
  int p[2];
  //creates pipe
  pipe(p);
  
  //forks
  pid = fork();
  //checks if fork worked
  if (pid < 0){
    printf("error");
    return 1;
   }
   //checks if child then runs command
   else if (pid == 0){
     //gets start time
     struct timeval st; 
     gettimeofday(&st, 0);
     //writes start time to pipe
     write(p[1], &st,sizeof(st));
     execvp(args[0],args);
    }
    //checks if parent then waits then exits
    else if (pid > 0){
      wait(NULL);
      //gets end time
      struct timeval end_time;
      gettimeofday(&end_time, 0 );
      //closes pipe
      close(p[1]);
      struct timeval startTime; 
      //reads from pipe
      read(p[0], &startTime, sizeof(startTime));
      //gets total time
      struct timeval elapsed_time;
      timersub(&end_time,&startTime,&elapsed_time );
      printf( "\nElapsed time: %ld.%06ld seconds\n", elapsed_time.tv_sec, elapsed_time.tv_usec );
      }
  return 0;
}

int main( int argc, char *argv[]){
 myShell(argc, argv);
 return 0;
}
