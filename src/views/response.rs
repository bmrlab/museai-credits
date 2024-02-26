use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct ModelResp<T> {
    pub data: T,
    pub code: i8,
    pub msg: String,
}

impl<T> ModelResp<T> {
    pub fn success(data: T) -> Self {
        Self {
            data,
            code: 0,
            msg: "success".to_string(),
        }
    }
}
