SELECT
    s.id as subscription_id,
    s.deactivated_at IS NULL
        AND EXISTS (
            SELECT FROM payments p
            WHERE
                p.subscription_id = s.id
                AND p.created_at >= (current_timestamp - '30 days'::interval)
                AND NOT EXISTS (SELECT FROM payment_cancellations pc WHERE pc.payment_id = p.id)
        ) as active
FROM
    subscriptions s
