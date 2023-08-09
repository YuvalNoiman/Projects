// time_shm.c : Gets run time using shm
// Created By: Yuval Noiman and two partners

#include <stdio.h>
#include <string.h>
#include <unistd.h> 
#include <sys/wait.h>
#include <sys/time.h>
#include <stdlib.h>

// The following to is for sharing memory regions
#include <sys/shm.h>
#include <sys/ipc.h>

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

  int sharedMemoryID;
  struct timeval *sharedStartTime;
  // Use shmget to share a memory region
  // 0666 to read and write
  // IPC_CREAT: make shared memory region
  // | for permissions
   // sizeof() to allocate space for the shared region
  sharedMemoryID = shmget(IPC_PRIVATE, sizeof(struct timeval), IPC_CREAT | 0666);
  sharedStartTime = (struct timeval *) shmat(sharedMemoryID, NULL, 0);

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
     gettimeofday(sharedStartTime, 0);
     execvp(args[0],args);
    }
    //checks if parent then waits then exits
    else if (pid > 0){
      wait(NULL);
      //gets end time
      struct timeval end_time;
      gettimeofday(&end_time, 0 );

      //gets total time
      struct timeval elapsed_time;
      timersub(&end_time,sharedStartTime,&elapsed_time );
      printf( "\nElapsed time: %ld.%06ld seconds\n", elapsed_time.tv_sec, elapsed_time.tv_usec );


      // Clear the shared memory region
      shmdt(sharedStartTime); // Detach
      shmctl(sharedMemoryID, IPC_RMID, NULL); // Removes
    }
  return 0;
}

int main( int argc, char *argv[]){
 myShell(argc, argv);
 return 0;
}
