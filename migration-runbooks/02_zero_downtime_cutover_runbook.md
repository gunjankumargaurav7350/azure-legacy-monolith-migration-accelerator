# 📖 Enterprise Zero-Downtime Monolith Migration Cutover Runbook
**Author:** Gunjan Kumar Gaurav (Senior Cloud Migration Architect)

## Phase Breakdown & Minute-by-Minute Execution

```
[ T-48 Hours: Continuous Data Replication ]
• Azure Database Migration Service (DMS) full + log backup sync
• Static assets migrated to Azure Blob Storage via AzCopy
• Pre-warming Azure Redis Session Cache
                    |
                    v
[ T-00: Cutover Window (Saturday 01:00 AM UTC) ]
1. Set On-Premises Web Tier into Read-Only Maintenance Mode
2. Drain active user sessions into Redis Cache
3. Final incremental transaction log backup to Azure SQL Managed Instance
4. Verify LSN (Log Sequence Number) match & recovery
5. Health probe validation on Azure App Service staging slot
6. Switch Azure Front Door backend pool origin from On-Premises to Azure
                    |
                    v
[ T+30 Minutes: Post-Cutover Telemetry & Sign-off ]
• Monitor P95 response latency in Azure Application Insights
• Verify SQL DTU / vCore utilization curves
• Business stakeholder sign-off & DNS TTL ramp-up
```
