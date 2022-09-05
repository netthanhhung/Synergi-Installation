/**********************************************************************************
- Destination: Server Instance that contains SYNERGI database.
- Before running this script : please change parameters like :
		@owner_login_name=N'ROCKCORP-LT-EM5\dev',
		@database_name=N'Synergi', 
		
- Job List :
1) [Synergi_CompleteFinancialsBatchSSIS]
2) [Synergi_MYOB Company File Import]
3) [Synergi_MYOB Site Specific Import]		
*************************************************************************************/

USE [msdb]
GO


/****** Object:  Job [Synergi_CompleteFinancialsBatchSSIS]    Script Date: 07/13/2012 11:11:45 ******/
IF NOT EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'Synergi_CompleteFinancialsBatchSSIS')
BEGIN

	BEGIN TRANSACTION
	DECLARE @ReturnCode INT
	SELECT @ReturnCode = 0
	/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 07/13/2012 11:11:46 ******/
	IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
	BEGIN
	EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

	END

	DECLARE @jobId BINARY(16)
	EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Synergi_CompleteFinancialsBatchSSIS', 
			@enabled=1, 
			@notify_level_eventlog=3, 
			@notify_level_email=2, 
			@notify_level_netsend=0, 
			@notify_level_page=0, 
			@delete_level=0, 
			@description=N'No description available.', 
			@category_name=N'[Uncategorized (Local)]', 
			@owner_login_name=N'ROCKCORP-LT-EM5\dev', 
			@notify_email_operator_name=N'Synergi Support', @job_id = @jobId OUTPUT
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	/****** Object:  Step [Execute CompleteFinancialsBatch under SSIS]    Script Date: 07/13/2012 11:11:48 ******/
	EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Execute CompleteFinancialsBatch under SSIS', 
			@step_id=1, 
			@cmdexec_success_code=0, 
			@on_success_action=1, 
			@on_success_step_id=0, 
			@on_fail_action=2, 
			@on_fail_step_id=0, 
			@retry_attempts=0, 
			@retry_interval=0, 
			@os_run_priority=0, @subsystem=N'SSIS', 
			@command=N'/DTS "\File System\TimeClockPackages\CompleteFinancialsBatch2008" /SERVER "ROCK-SQL02" /DECRYPT "priority2" /CONFIGFILE "C:\Program Files (x86)\Microsoft SQL Server\100\DTS\Packages\TimeClockPackages\CompleteFinancialsBatch2008.dtsConfig" /CHECKPOINTING OFF /REPORTING E', 
			@database_name=N'master', 
			@flags=0, 
			@proxy_name=N'Integration Services Proxy'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Synergi_CompleteFinancialsBatchSSISSchedule', 
			@enabled=1, 
			@freq_type=8, 
			@freq_interval=126, 
			@freq_subday_type=1, 
			@freq_subday_interval=0, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20100917, 
			@active_end_date=99991231, 
			@active_start_time=33000, 
			@active_end_time=235959, 
			@schedule_uid=N'c4cf4331-8968-44ec-9606-633f6393ff69'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	COMMIT TRANSACTION
	GOTO EndSave
	QuitWithRollback:
		IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
	EndSave:

END
GO



/****** Object:  Job [Synergi_MYOB Company File Import]    Script Date: 07/13/2012 11:12:39 ******/
IF NOT EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'Synergi_MYOB Company File Import')
BEGIN

	BEGIN TRANSACTION
	DECLARE @ReturnCode INT
	SELECT @ReturnCode = 0
	/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 07/13/2012 11:12:43 ******/
	IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
	BEGIN
	EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

	END

	DECLARE @jobId BINARY(16)
	EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Synergi_MYOB Company File Import', 
			@enabled=1, 
			@notify_level_eventlog=3, 
			@notify_level_email=2, 
			@notify_level_netsend=0, 
			@notify_level_page=0, 
			@delete_level=0, 
			@description=N'No description available.', 
			@category_name=N'[Uncategorized (Local)]', 
			@owner_login_name=N'ROCKCORP-LT-EM5\dev', 
			@notify_email_operator_name=N'Synergi Support', @job_id = @jobId OUTPUT
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	/****** Object:  Step [Run Import MYOB Data IS Package]    Script Date: 07/13/2012 11:12:44 ******/
	EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run Import MYOB Data IS Package', 
			@step_id=1, 
			@cmdexec_success_code=0, 
			@on_success_action=1, 
			@on_success_step_id=0, 
			@on_fail_action=2, 
			@on_fail_step_id=0, 
			@retry_attempts=0, 
			@retry_interval=0, 
			@os_run_priority=0, @subsystem=N'CmdExec', 
			@command=N'"C:\Program Files (x86)\Microsoft SQL Server\100\DTS\Binn\DTExec.exe" /DTS "\File System\TimeClockPackages\MyobImport2008" /SERVER "ROCK-SQL02" /DECRYPT "priority2" /CONFIGFILE "C:\Program Files (x86)\Microsoft SQL Server\100\DTS\Packages\TimeClockPackages\MyobImport2008.dtsConfig" /MAXCONCURRENT " -1 " /CHECKPOINTING OFF /REPORTING E', 
			@flags=0
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Run MYOB Import Job', 
			@enabled=1, 
			@freq_type=8, 
			@freq_interval=124, 
			@freq_subday_type=1, 
			@freq_subday_interval=0, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20100917, 
			@active_end_date=99991231, 
			@active_start_time=20000, 
			@active_end_time=235959, 
			@schedule_uid=N'45d629e9-9d6b-4dab-97cb-b950c4e8dfe8'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	COMMIT TRANSACTION
	GOTO EndSave
	QuitWithRollback:
		IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
	EndSave:

END
GO



/****** Object:  Job [Synergi_MYOB Site Specific Import]    Script Date: 07/13/2012 11:13:21 ******/
IF NOT EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'Synergi_MYOB Site Specific Import')
BEGIN

	BEGIN TRANSACTION
	DECLARE @ReturnCode INT
	SELECT @ReturnCode = 0
	/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 07/13/2012 11:13:22 ******/
	IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
	BEGIN
	EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

	END

	DECLARE @jobId BINARY(16)
	EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Synergi_MYOB Site Specific Import', 
			@enabled=1, 
			@notify_level_eventlog=3, 
			@notify_level_email=2, 
			@notify_level_netsend=0, 
			@notify_level_page=0, 
			@delete_level=0, 
			@description=N'No description available.', 
			@category_name=N'[Uncategorized (Local)]', 
			@owner_login_name=N'ROCKCORP-LT-EM5\dev', 
			@notify_email_operator_name=N'Synergi Support', @job_id = @jobId OUTPUT
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	/****** Object:  Step [Run the MYOBSiteSpecificImport SSIS Package]    Script Date: 07/13/2012 11:13:26 ******/
	EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run the MYOBSiteSpecificImport SSIS Package', 
			@step_id=1, 
			@cmdexec_success_code=0, 
			@on_success_action=1, 
			@on_success_step_id=0, 
			@on_fail_action=2, 
			@on_fail_step_id=0, 
			@retry_attempts=0, 
			@retry_interval=0, 
			@os_run_priority=0, @subsystem=N'CmdExec', 
			@command=N'"C:\Program Files (x86)\Microsoft SQL Server\100\DTS\Binn\dtexec.exe" /DTS "\File System\TimeClockPackages\MYOBSiteSpecificImport2008" /SERVER "ROCK-SQL02" /DECRYPT "priority2" /CONFIGFILE "C:\Program Files (x86)\Microsoft SQL Server\100\DTS\Packages\TimeClockPackages\MyobSiteSpecificImport2008.dtsConfig" /MAXCONCURRENT " -1 " /CHECKPOINTING OFF /REPORTING E', 
			@flags=0
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'TEMP_Invocation', 
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=4, 
			@freq_subday_type=1, 
			@freq_subday_interval=0, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20100126, 
			@active_end_date=99991231, 
			@active_start_time=124400, 
			@active_end_time=235959, 
			@schedule_uid=N'94f1e1dc-e97a-4b97-8ba0-91645c0a3b8c'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	COMMIT TRANSACTION
	GOTO EndSave
	QuitWithRollback:
		IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
	EndSave:

END
GO

