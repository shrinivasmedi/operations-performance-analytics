-- ============================================================
-- Operations Performance Analytics
-- SQL Analysis
-- Database: operations_analytics
-- Table: public.operations
-- ============================================================

-- Project objective:
-- Analyze operational productivity, efficiency, quality,
-- workforce performance, team performance, and shift performance.

-- Key metrics:
-- Cases Assigned
-- Cases Completed
-- Completion Rate
-- Target Achievement
-- Processing Time
-- Quality Score
-- Error Rate
-- Occupancy

-- ============================================================
-- 1. Overall Operational Performance
-- ============================================================

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT employee_id) AS total_employees,
    COUNT(DISTINCT team_id) AS total_teams,
    SUM(cases_assigned) AS total_cases_assigned,
    SUM(cases_completed) AS total_cases_completed,
    ROUND(AVG(completion_rate), 2) AS avg_completion_rate_pct,
    ROUND(AVG(target_achievement), 2) AS avg_target_achievement_pct,
    ROUND(AVG(avg_processing_time_cleaned), 2) AS avg_processing_time_min,
    ROUND(AVG(quality_score_cleaned), 2) AS avg_quality_score,
    ROUND(AVG(occupancy_pct_cleaned), 2) AS avg_occupancy_pct,
    ROUND(AVG(error_rate), 2) AS avg_error_rate_pct
FROM public.operations;

-- ============================================================
-- 2. Team Performance
-- ============================================================

SELECT
    team_id,
    COUNT(DISTINCT employee_id) AS employees,
    SUM(cases_assigned) AS cases_assigned,
    SUM(cases_completed) AS cases_completed,
    ROUND(AVG(completion_rate), 2) AS avg_completion_rate_pct,
    ROUND(AVG(target_achievement), 2) AS avg_target_achievement_pct,
    ROUND(AVG(avg_processing_time_cleaned), 2) AS avg_processing_time_min,
    ROUND(AVG(quality_score_cleaned), 2) AS avg_quality_score,
    ROUND(AVG(occupancy_pct_cleaned), 2) AS avg_occupancy_pct,
    ROUND(AVG(error_rate), 2) AS avg_error_rate_pct
FROM public.operations
GROUP BY team_id
ORDER BY avg_target_achievement_pct DESC;

-- ============================================================
-- 3. Shift Performance
-- ============================================================

SELECT
    shift_cleaned AS shift,
    COUNT(DISTINCT employee_id) AS employees,
    SUM(cases_assigned) AS cases_assigned,
    SUM(cases_completed) AS cases_completed,
    ROUND(AVG(completion_rate), 2) AS avg_completion_rate_pct,
    ROUND(AVG(target_achievement), 2) AS avg_target_achievement_pct,
    ROUND(AVG(avg_processing_time_cleaned), 2) AS avg_processing_time_min,
    ROUND(AVG(quality_score_cleaned), 2) AS avg_quality_score,
    ROUND(AVG(occupancy_pct_cleaned), 2) AS avg_occupancy_pct,
    ROUND(AVG(error_rate), 2) AS avg_error_rate_pct
FROM public.operations
GROUP BY shift_cleaned
ORDER BY avg_target_achievement_pct DESC;

-- ============================================================
-- 4. Employee Performance
-- ============================================================

SELECT
    employee_id,
    MAX(team_id) AS team_id,
    COUNT(*) AS records,
    ROUND(AVG(target_achievement), 2) AS avg_target_achievement_pct,
    ROUND(AVG(quality_score_cleaned), 2) AS avg_quality_score,
    ROUND(AVG(avg_processing_time_cleaned), 2) AS avg_processing_time_min,
    ROUND(AVG(occupancy_pct_cleaned), 2) AS avg_occupancy_pct,
    ROUND(AVG(error_rate), 2) AS avg_error_rate_pct,
    ROUND(AVG(completion_rate), 2) AS avg_completion_rate_pct
FROM public.operations
GROUP BY employee_id
ORDER BY avg_target_achievement_pct DESC;

-- ============================================================
-- 5. Monthly Performance Trend
-- ============================================================

SELECT
    DATE_TRUNC('month', date)::DATE AS month,
    COUNT(*) AS records,
    COUNT(DISTINCT employee_id) AS employees,
    COUNT(DISTINCT team_id) AS teams,
    SUM(cases_assigned) AS cases_assigned,
    SUM(cases_completed) AS cases_completed,
    ROUND(AVG(completion_rate), 2) AS avg_completion_rate_pct,
    ROUND(AVG(avg_processing_time_cleaned), 2) AS avg_processing_time_min,
    ROUND(AVG(quality_score_cleaned), 2) AS avg_quality_score,
    ROUND(AVG(occupancy_pct_cleaned), 2) AS avg_occupancy_pct,
    ROUND(AVG(error_rate), 2) AS avg_error_rate_pct,
    ROUND(AVG(target_achievement), 2) AS avg_target_achievement_pct
FROM public.operations
GROUP BY DATE_TRUNC('month', date)
ORDER BY month;